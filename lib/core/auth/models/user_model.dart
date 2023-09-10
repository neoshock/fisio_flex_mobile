// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String firstName;
  String lastName;
  String docNumber;
  String phone;
  String description;
  DateTime birthDate;
  String createdAt;
  String updatedAt;
  String role;
  dynamic categoryId;
  dynamic categoryName;
  bool status;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.docNumber,
    required this.phone,
    required this.description,
    required this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.categoryId,
    required this.categoryName,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        docNumber: json["docNumber"],
        phone: json["phone"],
        description: json["description"],
        birthDate: DateTime.parse(json["birthDate"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        role: json["role"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "docNumber": docNumber,
        "phone": phone,
        "description": description,
        "birthDate": birthDate.toIso8601String(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "role": role,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "status": status,
      };
}
