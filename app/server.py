import pymysql
import tornado.httpserver
import tornado.ioloop
import tornado.web

from app.handler import CreateQueueHandler, UpdateStatusHandler, SendMessageHandler, AcknowledgeMessagehandler
from app.settings import settings
from app.config import connection


class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/create_queue", CreateQueueHandler),
            (r"/update_status", UpdateStatusHandler),
            (r"/send", SendMessageHandler),
            (r"/acknowledge", AcknowledgeMessagehandler),
        ]
        super(Application, self).__init__(handlers, **settings)

        self.db = connection
        self.cur = self.db.cursor(pymysql.cursors.DictCursor)


def main():
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(8000)
    tornado.ioloop.IOLoop.current().start()
