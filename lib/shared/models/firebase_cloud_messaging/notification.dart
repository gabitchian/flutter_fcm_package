import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false)
class NotificationWidget {
  final String? title;
  final String? body;
  final String? image;

  NotificationWidget({
    required this.title,
    required this.body,
    this.image,
  });

  NotificationWidget copyWith({
    String? title,
    String? body,
    String? image,
  }) {
    return NotificationWidget(
        title: title ?? this.title,
        body: body ?? this.body,
        image: image ?? this.image);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'image': image,
    };
  }

  factory NotificationWidget.fromMap(Map<String, dynamic> map) {
    return NotificationWidget(
      title: map['title'],
      body: map['body'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationWidget.fromJson(String source) =>
      NotificationWidget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMessage(title: $title, body: $body, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationWidget &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return title.hashCode ^ body.hashCode;
  }
}
