const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;
var fromId = "";
var toId = "";
var fromName = "";
var sendTokens = [];
var payLoad = {};
var commenterName = "";
exports.chatTrigger = functions.firestore.document('notifMessages/{messageId}').onCreate((snapshot, context) => {
    msgData = snapshot.data();
    fromId = msgData.from;
    toId = msgData.to;
    console.log(msgData)
    console.log(fromId);
    console.log(toId);

    if (fromId !== toId) {
        admin.firestore().collection('users').doc(toId).get().then(function(doc) {
            sendTokens = doc.data().tokens;
            console.log(sendTokens);
            admin.firestore().collection('users').doc(fromId).get().then(function(doc) {
                fromName = doc.data().displayName;
                payLoad = {
                    "notification": {
                        "title": fromName,
                        "body": msgData.text,
                        "sound": "default"
                    },
                    "data": {
                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                         "title": fromName,
                         "body": msgData.text,
                        "senderId": fromId,
                        "notifType": "chat"
                    }
                }
                console.log(fromName);
                return admin.messaging().sendToDevice(sendTokens, payLoad).then((response) => {
                    console.log('Pushed them all');
                }).catch((err) => {
                    console.log(err);
                });
            });
        });
    }
});

exports.postNotifTrigger = functions.firestore.document('postNotifs/{notifId}').onCreate((snapshot, context) => {
    notifData = snapshot.data();
    commenterId = notifData.commenterId;
    ownerId = notifData.ownerId;
    commenterName = notifData.commenterName;

    if (commenterId !== ownerId) {
        admin.firestore().collection('users').doc(ownerId).get().then(function(doc) {
            sendTokens = doc.data().tokens;
            admin.firestore().collection('users').doc(commenterId).get().then(function(doc) {
                fromName = commenterName;
                payLoad = {
                    "notification": {
                        "title": "Your post has a new comment from " + fromName,
                        "body": notifData.text,
                        "sound": "default"
                    },
                    "data": {
                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                        "title": "Your post has a new comment from " + fromName,
                        "body": notifData.text,
                        "notifType": "postNotif",
                        "postId": notifData.postID,
                        "type": notifData.type
                    }
                }
                console.log(payLoad)
                return admin.messaging().sendToDevice(sendTokens, payLoad).then((response) => {
                    console.log('Pushed them all');
                }).catch((err) => {
                    console.log(err);
                });
            });
        });
    }
});

exports.streamNotifTrigger = functions.firestore.document('streamNotifs/{notifId}').onCreate((snapshot, context) => {
    notifData = snapshot.data();
    channelName = notifData.stream;
    caption = notifData.caption;
    ownerId = notifData.ownerId;
    university = notifData.university;
    uniqueStream = university + channelName;
    uniqueStream = uniqueStream.replace(/\s/g, '');
    
    console.log(uniqueStream);

    payLoad = {
        "notification": {
            "title": channelName,
            "body": caption,
            "sound": "default"
        },
        "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "title": channelName,
            "body": caption,
            "notifType": "streamNotif",
            "ownerId": ownerId
        }
    };

    return admin.messaging().sendToTopic(uniqueStream, payLoad).then((response) => {
        console.log('Pushed them all');
        }).catch((err) => {
            console.log(err);
    });
});