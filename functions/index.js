const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;
var fromId = "test";
var toId = "test";
var fromName = "test";
var sendTokens = [];
var payLoad = {};
//var tempToken = ['fEE3RHfDlZs:APA91bHNLKudqN8JcbR5NM_xSuQHf9wb1jWZTzcPFpzPbOJFgQ-V3naynpEVlVbYm5aenEHv_L4ZfvRsCYA4-nmc4mZzv50j8eqz2lYQrgs8FH2nc77SZ4ii1Vjc41NZ9Vm8f2nkBAZ1']
var tempToken = ["dX4lKMAvq_Q:APA91bFY_hCFMgRQIxV334etgAlxIBFLmt5Tc5GkFG9ROi9MUx-DKVcmHp5abMt3cM8J8EzEOsajg_nCd5Z_NLBZUHHQ7splFA3FUrP6C1GSDYQWuMjemCRz16UdgQ4mVPT6Gbpcxh0g"];
exports.chatTrigger = functions.firestore.document('notifMessages/{messageId}').onCreate((snapshot, context) => {
    msgData = snapshot.data();
    fromId = msgData.from;
    toId = msgData.to;
    console.log(msgData)
    console.log(fromId);
    console.log(toId);

    await admin.firestore().collection('users').doc(toId).get().then(function(doc) {
        sendTokens = doc.data().tokens;
        await admin.firestore().collection('users').doc(fromId).get().then(function(doc) {
            fromName = doc.data().displayName;
            payLoad = {
                "notification": {
                    "title": "New message from " + fromName,
                    "body": msgData.text,
                    "sound": "default"
                },
                "data": {
                    "senderName": fromName,
                    "message": msgData.text
                }
            }
            console.log(fromName);
            console.log(sendTokens);


        });
    });

    return admin.messaging().sendToDevice("dX4lKMAvq_Q:APA91bFY_hCFMgRQIxV334etgAlxIBFLmt5Tc5GkFG9ROi9MUx-DKVcmHp5abMt3cM8J8EzEOsajg_nCd5Z_NLBZUHHQ7splFA3FUrP6C1GSDYQWuMjemCRz16UdgQ4mVPT6Gbpcxh0g", payLoad).then((response) => {
        console.log('Pushed them all');
    }).catch((err) => {
        console.log(err);
    });

//     payLoad = {
//         "notification": {
//             "title": "New message from " + fromName,
//             "body": "test",
//             "sound": "default"
//         },
//         "data": {
//             "senderName": fromName,
//             "message": "test"
//         }
//     }
//     console.log(fromName);
//     console.log(sendTokens);

//     return admin.messaging().sendToDevice("dX4lKMAvq_Q:APA91bFY_hCFMgRQIxV334etgAlxIBFLmt5Tc5GkFG9ROi9MUx-DKVcmHp5abMt3cM8J8EzEOsajg_nCd5Z_NLBZUHHQ7splFA3FUrP6C1GSDYQWuMjemCRz16UdgQ4mVPT6Gbpcxh0g", payLoad).then((response) => {
//         console.log('Pushed them all');
//     }).catch((err) => {
//         console.log(err);
//     });
});


