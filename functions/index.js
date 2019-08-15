const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;
var fromId = "test";
var toId = "test";
var fromName = "test";
var sendTokens = [];
var payLoad = {};
var tempToken = ["dX4lKMAvq_Q:APA91bFY_hCFMgRQIxV334etgAlxIBFLmt5Tc5GkFG9ROi9MUx-DKVcmHp5abMt3cM8J8EzEOsajg_nCd5Z_NLBZUHHQ7splFA3FUrP6C1GSDYQWuMjemCRz16UdgQ4mVPT6Gbpcxh0g"];
var commenterName = "test";
exports.chatTrigger = functions.firestore.document('notifMessages/{messageId}').onCreate((snapshot, context) => {
    msgData = snapshot.data();
    fromId = msgData.from;
    toId = msgData.to;
    console.log(msgData)
    console.log(fromId);
    console.log(toId);

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
});

exports.postNotifTrigger = functions.firestore.document('postNotifs/{notifId}').onCreate((snapshot, context) => {
    notifData = snapshot.data();
    commenterId = notifData.commenterId;
    ownerId = notifData.ownerId;
    commenterName = notifData.commenterName;

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
});

    // payLoad = {
    //     "notification": {
    //         "title": "New message from " + fromName,
    //         "body": "test",
    //         "sound": "default"
    //     },
    //     "data": {
    //         "senderName": fromName,
    //         "message": "test"
    //     }
    // }
    // console.log(fromName);
    // console.log(sendTokens);

    // return admin.messaging().sendToDevice("eRc5HvOhUVo:APA91bEkJHQF4hJcBUH8QqGTjg0IQ_GeEJpIvL5EnfqW7sHWURYC7gNmPUY-uOLJMvH5ysMzBYTsKnvliWszXyFdgEUMMcbAhh7aEbaHYNwxNNYpmjrvK20FJmdvq0go4QB044yJhDkh", payLoad).then((response) => {
    //     console.log('Pushed them all');
    // }).catch((err) => {
    //     console.log(err);
    //"eRc5HvOhUVo:APA91bEkJHQF4hJcBUH8QqGTjg0IQ_GeEJpIvL5EnfqW7sHWURYC7gNmPUY-uOLJMvH5ysMzBYTsKnvliWszXyFdgEUMMcbAhh7aEbaHYNwxNNYpmjrvK20FJmdvq0go4QB044yJhDkh"
    // });