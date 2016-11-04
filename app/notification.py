import time
from concurrent.futures import ThreadPoolExecutor

import boto3
from tornado import concurrent, ioloop

from app.settings import connection, cursor


def create_timestamp():
    return str(int(time.time()))


class Notification(object):

    def __init__(self):
        self.sqs = boto3.resource('sqs')
        self.executor = ThreadPoolExecutor(max_workers=4)
        self.io_loop = ioloop.IOLoop.current()

    def get_queue_name(self, queue_id):
        sql = "SELECT * FROM queue WHERE id=%s"
        cursor.execute(sql, (queue_id))
        queue = cursor.fetchone()
        queue_name = queue.get('name')

        return queue_name

    def _is_queue_active(self, queue_id):

        sql = "SELECT acknowledgement.message_id, queue.id_of_last_msg_acknowledged FROM acknowledgement INNER JOIN queue ON acknowledgement.queue_id=queue.id WHERE queue.id=%s ORDER BY acknowledgement.message_id"

        cursor.execute(sql, (queue_id))
        messages = cursor.fetchall()

        if messages[0].get('message_id') == messages[0].get('id_of_last_msg_acknowledged') or abs(messages[0].get('message_id') - messages[0].get('id_of_last_msg_acknowledged')) <= 1:
            return True

        else:
            return False

    def _delete_queue(self, queue_id):

        queue = self.sqs.get_queue_by_name(QueueName=self.get_queue_name())
        queue.delete()
        sql = "DELETE FROM queue WHERE id=%s"
        cursor.execute(sql, (queue_id))
        connection.commit()
        connection.close()
        return {"message": "queue is successfully deleted"}

    def _delete_message(self, queue_id, message_id):

        queue = self.sqs.get_queue_by_name(QueueName=self.get_queue_name(queue_id))

        for message in queue.receive_messages():
            if message.message_id == message_id:
                message.delete()
                break

        return {"message": "message is successfully deleted"}

    @concurrent.run_on_executor
    def create_queue(self, user_id):

        queue_name = str("Dev-"+user_id+"-"+create_timestamp())  # TODO: get the environment name from a method or a cleaner way

        queue = self.sqs.create_queue(QueueName=queue_name, Attributes={'DelaySeconds': '5'})
        queue_url = queue.url
        queue_info = {
            "queue_name": queue_name,
            "queue_url": str(queue_url),
            "time_created": str(create_timestamp()),
            "id_of_last_read_message": 2,
            "no_of_messages_sent": 0,  # TODO: implement the next 3 as methods
            'id_of_last_message': 0,
            'id_of_last_message_acknowledge': 0
        }

        sql = "INSERT INTO queue (user_id, url, no_of_msg_sent, id_of_last_msg, name) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(sql, (user_id, queue_info['queue_url'], 0, 0, queue_info['queue_name']))
        connection.commit()
        connection.close()

        return queue_info

    @concurrent.run_on_executor
    def send_message(self, user_id, payload, queue_id):

        queue = self.sqs.get_queue_by_name(QueueName=self.get_queue_name(queue_id))

        response = queue.send_message(MessageBody=payload)

        sql = "INSERT INTO message (user_id, queue_id) VALUES (%s, %s)"
        cursor.execute(sql, (user_id, queue_id))
        connection.commit()
        connection.close()

        return response

    @concurrent.run_on_executor
    def acknowledge_message(self, user_id, queue_id, message_id):

        try:
            sql = "INSERT INTO acknowledgement (user_id, queue_id, message_id) VALUES (%s, %s, %s)"
            cursor.execute(sql, (user_id, queue_id, message_id))
            connection.commit()

            return {"message": "Successfully acknowledged"}
        except:
            return {"message": "Failed"}


