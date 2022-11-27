import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fcm_package/shared/models/firebase_cloud_messaging/message.dart';
import 'package:flutter_fcm_package/shared/models/firebase_cloud_messaging/notification.dart';
import 'package:flutter_fcm_package/shared/models/firebase_cloud_messaging/to.dart';
import 'package:flutter_fcm_package/shared/models/notification_message.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_fcm_package/shared/configuration/configuration.dart';
import 'package:uuid/uuid.dart';

class SendNotificationService {
  String _from = "";
  final List<To> _to = [];

  SendNotificationService();

  SendNotificationService addFrom(String from) {
    _from = from;
    return this;
  }

  SendNotificationService addReceiver(To receiver) {
    _to.add(receiver);
    return this;
  }

  List<String> getReceiverTokens() {
    return _to.map((e) => e.token!).toList();
  }

  List<String> getReceiverIds() {
    return _to.map((e) => e.id).toList();
  }

  /** TODO: 
   * [ ] improve code used to set notifications in firestore
   * [ ] improve code used to update notifications in firestore
   * */
  _saveNotificationToFirebase(NotificationWidget notification) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    NotificationMessage notificationMessage = NotificationMessage(
      id: const Uuid().v4().replaceAll("-", ""),
      title: notification.title,
      description: notification.body,
      image: notification.image,
      from: _from,
      sentAt: DateTime.now(),
    );

    List<Future<void>> awaitList = getReceiverIds().map((id) async {
      DocumentSnapshot<Object?> value = await users.doc(id).get();
      if (value.data() == null) {
        users
            .doc(id)
            .set(
              {
                'notifications': [notificationMessage.toMap()]
              },
            )
            .then((value) =>
                print('Added notification: ${notification.toString()}'))
            .catchError((value) {
              print(
                  'Error while adding notification: ${notification.toString()}');

              print('Error while adding notification: ${value.toString()}');
            });
      } else {
        users
            .doc(id)
            .update(
              {
                'notifications':
                    FieldValue.arrayUnion([notificationMessage.toMap()])
              },
            )
            .then((value) =>
                print('Added notification: ${notification.toString()}'))
            .catchError((value) {
              print(
                  'Error while adding notification: ${notification.toString()}');

              print('Error while adding notification: ${value.toString()}');
            });
      }
    }).toList();

    Future.wait(awaitList);
  }

  sendNotification(NotificationWidget notification) async {
    await _saveNotificationToFirebase(notification);
    Message message = Message(
      registrationIds: getReceiverTokens(),
      notification: notification,
    );

    Map<String, String> headers = {
      'Authorization': 'key=${Configuration.serverKey}',
      'Content-type': 'application/json',
    };
    print(message.toJson());
    final response = await http.post(Uri.parse(Configuration.notificationUrl),
        headers: headers, body: message.toJson());

    if (response.statusCode >= 200 && response.statusCode < 300)
      print("Sucesso");
    else {
      print("Something happend: ${response.statusCode}");
      print("Something happend: ${jsonEncode(response.body)}");
    }
  }
}
