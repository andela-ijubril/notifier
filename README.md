# Notification Service

Basic Notification that allows 
Notification Service class that has the following methods 
* createQueue(userId) 
* sendMessage(userId, payload) 
* acknowledgeMessage(userId, queueId, messageId) 
* _isQueueActive(queueId) 
* _deleteQueue(queueId) 
* _deleteMessage(queueId, messageId)


create a virtual environment and activate
run pip install -r requirements.txt

To run:

create a mysql database bloomz_test
do an sql dump of the data
```
python runserver.py
```

You can test the functionality on postman

```
POST /create_queue body(user_id)
POST /update_status body(user_id, message)
POST /send   body(user_id, payload, queue_id)
POST /acknowledge body(user_id, message_id, queue_id)
```
