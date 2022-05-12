import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.passwordConfirmation,
  });

  String name;
  String email;
  String phoneNumber;
  String address;
  String password;
  String passwordConfirmation;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

GetLogin getLoginFromJson(String str) => GetLogin.fromJson(json.decode(str));

String getLoginToJson(GetLogin data) => json.encode(data.toJson());

class GetLogin {
  GetLogin({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory GetLogin.fromJson(Map<String, dynamic> json) => GetLogin(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.avatar,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String role;
  String avatar;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        role: json["role"],
        avatar: json["avatar"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "role": role,
        "avatar": avatar,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
