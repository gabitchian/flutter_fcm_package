import 'dart:convert';

class NotificationMessage {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final String? from;
  final DateTime? sentAt;
  final Map<String, dynamic>? data;

  NotificationMessage({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.from,
    required this.sentAt,
    this.data,
  });

  NotificationMessage copyWith(
      {String? id,
      String? title,
      String? description,
      String? image,
      String? from,
      DateTime? sentAt,
      Map<String, dynamic>? data}) {
    return NotificationMessage(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      from: from ?? this.from,
      sentAt: sentAt ?? this.sentAt,
      image: image ?? this.image,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'from': from,
      'sent_at': sentAt,
      'image': image,
      'data': data,
    };
  }

  factory NotificationMessage.fromMap(Map<String, dynamic> map) {
    return NotificationMessage(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      from: map['from'],
      sentAt: map['sent_at'],
      image: map['image'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMessage.fromJson(String source) =>
      NotificationMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMessage(id: $id, from: $from, sentAt: $sentAt, title: $title, description: $description, image: $image, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationMessage &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode;
  }
}
