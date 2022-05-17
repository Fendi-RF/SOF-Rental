// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    required this.id,
    required this.transactionCode,
    required this.idRental,
    required this.cashier,
    required this.paymentType,
    required this.paidDate,
    required this.payerName,
    required this.bank,
    required this.paymentProof,
    required this.noRef,
    required this.paidTotal,
    required this.createdAt,
    required this.updatedAt,
  });
  int? id;
  String? transactionCode;
  String? idRental;
  String? cashier;
  String? paymentType;
  DateTime? paidDate;
  String? payerName;
  String? bank;
  String? paymentProof;
  String? noRef;
  String? paidTotal;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        transactionCode: json["transaction_code"],
        idRental: json["id_rental"],
        cashier: json["cashier"],
        paymentType: json["payment_type"],
        paidDate: DateTime.parse(
            json["paid_date"] ?? DateTime.now().toIso8601String()),
        payerName: json["payer_name"],
        bank: json["bank"],
        paymentProof: json["payment_proof"],
        noRef: json["no_ref"],
        paidTotal: json["paid_total"],
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_code": transactionCode,
        "id_rental": idRental,
        "cashier": cashier,
        "payment_type": paymentType,
        "paid_date": paidDate?.toIso8601String(),
        "payer_name": payerName,
        "bank": bank,
        "payment_proof": paymentProof,
        "no_ref": noRef,
        "paid_total": paidTotal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
