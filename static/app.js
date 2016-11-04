/**
 * Created by masterp on 03/11/2016.
 */

$(document).ready(function () {
    var Constants = {
        //wsURL: 'ws://' + window.location.host + window.location.pathname + '/ws',
        NOTIFICATION_SERVICE_API_URL: 'http://' + window.location.host,
        AWS_ACCESS_KEY_ID: "",
        AWS_SECRET_ACCESS_KEY: "",
        AWS_REGION: ""
    };

    var pendingMessages = [];

    var lastMessageRead = null;

    var login = function () {
      displayQueue();
      startReceivingMessages("https://sqs.us-west-2.amazonaws.com/346741110300/test");
         var username = $("#username").val();
         var password = $("#password").val();

         if (username != "" && password != "") {
             $("#loginButton").addClass("disabled");

             $.post({
                 url: Constants.NOTIFICATION_SERVICE_API_URL + "/login",
                 data: {
                     username: username,
                     password: password
                 }
             })
             .done(function (response) {
                 displayQueue();
                 startReceivingMessages(response.queue_url);
                 //startReceivingMessages(response.endpoint);
             })
             .fail(function () {
                 $("#loginButton").removeClass("disabled");
             });
         }
    };

    var startReceivingMessages = function (endpoint) {
        var sqs = new AWS.SQS({
          "accessKeyId": Constants.AWS_ACCESS_KEY_ID,
          "secretAccessKey": Constants.AWS_SECRET_ACCESS_KEY,
          "region": Constants.AWS_REGION
        });

        setInterval(function () {
            sqs.receiveMessage({
                QueueUrl: endpoint,
                AttributeNames: [ "All" ],
                MaxNumberOfMessages: 10,
                MessageAttributeNames: [ "All" ]
                // VisibilityTimeout: 1000
            }, function (error, data) {
              if (error) {
                  console.log(error);
              } else {
                  for (var i = 0; i < data.Messages.length; ++i) {
                    var message = JSON.parse(data.Messages[i].Body);

                    if (lastMessageRead == null) {
                        acknowledgeAndProcessMessage(message);
                    } else {
                      if (message.id <= lastMessageRead.id) {
                          continue;
                      }

                      if (message.lastMessageSentId < lastMessageRead.id) {
                          continue;
                      }

                      if (message.lastMessageSentId > lastMessageRead.id) {
                          pendingMessages.push(message);
                          continue;
                      }

                      pendingMessages.sort(function (a, b) { return a.id - b.id })
                                     .forEach(processMessage);

                      acknowledgeAndProcessMessage(message);
                    }
                  }
              }
            });

        }, 2000);
    };

    var acknowledgeAndProcessMessage = function (message) {
      lastMessageRead = message;
      processMessage(message);
      acknowledgeMessage(message);
    }

    var processMessage = function (message) {
        $("#messages").prepend(
            $("<p>").addClass("message").text(message.content)
        );
    };

    var acknowledgeMessage = function (message) {
          // $.post({
          //     url: Constants.NOTIFICATION_SERVICE_API_URL + "/aknowledge_message",
          //     data: message
          // })
          // .done(function (response) { })
          // .fail(function () { });
    };

    var displayQueue = function () {
      $("#login").fadeOut("500");
      $("#login").css("display", "none");
      $("#queue").fadeIn("500");
      $("#queue").css("display", "block");
    }

    $("#loginButton").click(login);
});
