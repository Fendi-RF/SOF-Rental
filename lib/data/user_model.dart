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
        passwordConfirmation: json["password_confirmation "],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "password": password,
        "password_confirmation ": passwordConfirmation,
      };
}
