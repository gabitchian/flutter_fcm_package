import 'dart:convert';

class To {
  String id;
  String? token;

  To({required this.id, required this.token});

  To copyWith({
    String? id,
    String? token,
  }) {
    return To(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
    };
  }

  factory To.fromMap(Map<String, dynamic> map) {
    return To(
      id: map['id'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory To.fromJson(String source) => To.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMessage(id: $id, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is To && other.id == id && other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^ token.hashCode;
  }
}
