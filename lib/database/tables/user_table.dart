import 'dart:convert';

class UserTable {
  int? uId;
  String? name;
  String? email;
  String? fcmToken;


  UserTable({
    this.uId,
    this.name,
    this.email,
    this.fcmToken,

  });

  factory UserTable.fromRawJson(String str) =>
      UserTable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTable.fromJson(Map<String, dynamic> json) => UserTable(
    uId: json["uId"],
    name: json["Name"],
    email: json["Email"],
    fcmToken: json["FcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "uId": uId,
    "Name": name,
    "Email": email,
    "FcmToken": fcmToken,
  };
}












