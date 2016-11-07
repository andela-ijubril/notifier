import tornado.escape
import tornado.httpserver
import tornado.ioloop
import tornado.web
from tornado import gen

from app.notification import Notification
from app.config import connection, cursor


notification = Notification()


class CreateQueueHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        data = tornado.escape.json_decode(self.request.body)
        user_id = data.get('user_id')

        queue_info = yield notification.create_queue(str(user_id))
        self.write(queue_info)


class AcknowledgeMessagehandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        data = tornado.escape.json_decode(self.request.body)
        user_id = data.get('user_id')
        message_id = data.get('message_id')
        queue_id = data.get('queue_id')

        has_acknowledged = yield notification.acknowledge_message(user_id, queue_id, message_id)

        self.write(has_acknowledged)


class UpdateStatusHandler(tornado.web.RequestHandler):

    def post(self, *args, **kwargs):

        data = tornado.escape.json_decode(self.request.body)
        user_id = data.get('user_id')
        string = data.get('message')

        sql = "Insert INTO status (user_id, value) VALUES (%s, %s)"
        cursor.execute(sql, (user_id, string))
        connection.commit()

        self.write("status updated")


class SendMessageHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def post(self, *args, **kwargs):
        data = tornado.escape.json_decode(self.request.body)
        user_id = data.get('user_id')
        payload = data.get('paylaod')
        queue_id = data.get('queue_id')

        response = yield notification.send_message(user_id, payload, queue_id)

        self.write(response)
