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

# define("port", default=8888, help="run on the given port", type=int)
# define("mysql_host", default="127.0.0.1:3306", help="blog database host")
# define("mysql_database", default="bloomz_test", help="blog database name")
# define("mysql_user", default="blog", help="blog database user")
# define("mysql_password", default="blog", help="blog database password")


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
        # self.db.close()


        sql = "SELECT * FROM queue WHERE user_id=%s"
        cursor.execute(sql, (user_id))
        queues = self.cursor.fetchall()
        connection.close()
        # self.write(queues)
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

