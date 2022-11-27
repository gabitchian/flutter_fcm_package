import 'dart:convert';

import 'package:flutter_fcm/shared/models/firebase_cloud_messaging/notification.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false)
class Message {
  final List<String> registrationIds;
  final NotificationWidget notification;
  final Map<String, dynamic>? data;

  Message({
    required this.registrationIds,
    required this.notification,
    this.data,
  });

  Message copyWith({
    List<String>? registrationIds,
    NotificationWidget? notification,
    Map<String, dynamic>? data,
  }) {
    return Message(
      registrationIds: registrationIds ?? this.registrationIds,
      notification: notification ?? this.notification,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'registration_ids': registrationIds,
      'notification': notification.toMap(),
      'data': data,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      registrationIds: map['registration_ids'],
      notification: map['notification'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMessage(registrationIds: ${registrationIds.toString()}, notification: ${notification.toMap()}, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.registrationIds == registrationIds &&
        other.data == data &&
        other.notification == notification;
  }

  @override
  int get hashCode {
    return registrationIds.hashCode ^ notification.hashCode ^ data.hashCode;
  }
}
