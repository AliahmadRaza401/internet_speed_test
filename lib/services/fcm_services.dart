// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FCMServices {
  static var fcmServerKey =
      'AAAA7z9EzOA:APA91bHhClAVwPcxLyPDrdVBCIDva3_9xE-YpnUfP8YDpBYAZ3L8IrImTE-PbvMLqCM9obuLIbJCmr5YoHZCa4z9XYCBr3PxvysCGhQI4TxAIU2rugpsPGtpQN3a9DMNMnP3DbXfsfsZ';

//  get device token
  static generateFCMToken() async {
    var token;
    try {
      token = await FirebaseMessaging.instance.getToken().then((value) {
        // print("Device Token: $value");
        return value;
      });
      return token;
    } catch (e) {
      print("Device Token e: $e");
      return e;
    }
  }

// listen onApp FCM
  static listenAppFCM() {
    FirebaseMessaging.onMessage.listen((event) {
      print("OnApp FCM : $event");

      String title = event.notification!.title.toString();
      String body = event.notification!.body.toString();

      print(title);
      print(body);
      displyNotification(title: title, body: body);
    });
  }

  // listen background FCM

  static listenbackgroundFCM(RemoteMessage message) {
    print("FCM message");

    var title = message.notification!.title;
    var body = message.notification!.body;
    displyNotification(title: title.toString(), body: body.toString());
  }

  // createLocalNotificaion()
  static displyNotification({required String title, required String body}) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));

    flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        "1",
        "test",
        // playSound: true,
        // priority: Priority.high,
        // importance: Importance.high,
        // enableVibration: true,
      )),
    );
  }

  static sendFCMNotification() async {
    final responce = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$fcmServerKey'
      },
      body: jsonEncode({
        'to': '',
        'notification': {
          'title': '',
          'body': '',
        }
      }),
    );
  }
}
