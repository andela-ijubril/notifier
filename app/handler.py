import json
import time

import tornado.escape
import tornado.httpserver
import tornado.ioloop
import tornado.web
from bson import json_util
from tornado import gen
from tornado.options import define

from app.notification import Notification

from app.settings import connection, cursor


notification = Notification()


class CreateQueueHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        user_id = self.get_argument('user_id')

        queue_info = yield notification.create_queue(str(user_id))
        self.write(queue_info)


class AcknowledgeMessagehandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        user_id = self.get_argument('user_id')
        message_id = self.get_argument('message_id')
        queue_id = self.get_argument('queue_id')

        has_acknowledged = yield notification.acknowledge_message(user_id, queue_id, message_id)

        self.write(has_acknowledged)


class UpdateStatusHandler(tornado.web.RequestHandler):

    @property
    def db(self):
        return self.application.db

    @property
    def cursor(self):
        return self.application.cur


    def post(self, *args, **kwargs):

        data = tornado.escape.json_decode(self.request.body)

        user_id = data.get('username')
        string = data.get('message')

        sql = "Insert INTO status (user_id, value) VALUES (%s, %s)"
        cursor.execute(sql, (user_id, string))
        connection.commit()



        sql = "SELECT * FROM queue WHERE user_id=%s"
        cursor.execute(sql, (user_id))
        queues = self.cursor.fetchall()
        connection.close()
    
        self.write(json.dumps(queues, default=json_util.default))


class SendMessageHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        user_id = self.get_argument('user_id')
        payload = self.get_argument('paylaod')
        queue_id = self.get_argument('user_id')

        response = yield notification.send_message(user_id, payload, queue_id)

        self.write(response)


def create_timestamp():
    return str(int(time.time()))

