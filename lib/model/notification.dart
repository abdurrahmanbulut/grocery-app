class UserNotification{
  String id;
  String desc;
  DateTime time = DateTime.now();
  bool isSeen = false;

  UserNotification(this.id, this.desc,this.time,this.isSeen);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc':desc,
      'time':time.toIso8601String(),
      'isSeen': isSeen
    };
  }
  factory UserNotification.fromJson(Map<String, dynamic> json) => UserNotification(
    json["id"],
    json["desc"],
    DateTime.tryParse(json['time']) as DateTime,
    json["isSeen"]
  );
}