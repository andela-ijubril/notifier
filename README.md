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
