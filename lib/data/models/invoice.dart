// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'package:car_rental_app_ui/data/models/payment.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<Invoice> invoiceFromJson(String str) =>
    List<Invoice>.from(json.decode(str).map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
  Invoice({
    required this.id,
    required this.transactionCode,
    required this.userId,
    required this.idVehicle,
    required this.startRentDate,
    required this.endRentDate,
    required this.vehiclePicked,
    required this.vehicleReturned,
    required this.status,
    required this.reason,
    required this.guaranteRent1,
    this.guaranteRent2,
    this.guaranteRent3,
    required this.rentPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.payment,
    required this.vehicleSpec,
  });

  int id;
  String transactionCode;
  String userId;
  String idVehicle;
  DateTime startRentDate;
  DateTime endRentDate;
  dynamic vehiclePicked;
  dynamic vehicleReturned;
  String status;
  dynamic reason;
  String guaranteRent1;
  dynamic guaranteRent2;
  dynamic guaranteRent3;
  String rentPrice;
  DateTime createdAt;
  DateTime updatedAt;
  Payment? payment;
  VehicleSpec vehicleSpec;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        transactionCode: json["transaction_code"],
        userId: json["user_id"],
        idVehicle: json["id_vehicle"],
        startRentDate: DateTime.parse(json["start_rent_date"]),
        endRentDate: DateTime.parse(json["end_rent_date"]),
        vehiclePicked: json["vehicle_picked"],
        vehicleReturned: json["vehicle_returned"],
        status: json["status"],
        reason: json["reason"],
        guaranteRent1: json["guarante_rent_1"],
        guaranteRent2: json["guarante_rent_2"],
        guaranteRent3: json["guarante_rent_3"],
        rentPrice: json["rent_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        payment: Payment.fromJson(json["payment"] ?? {}),
        vehicleSpec: VehicleSpec.fromJson(json["vehicle_spec"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_code": transactionCode,
        "user_id": userId,
        "id_vehicle": idVehicle,
        "start_rent_date": startRentDate.toIso8601String(),
        "end_rent_date": endRentDate.toIso8601String(),
        "vehicle_picked": vehiclePicked,
        "vehicle_returned": vehicleReturned,
        "status": status,
        "reason": reason,
        "guarante_rent_1": guaranteRent1,
        "guarante_rent_2": guaranteRent2,
        "guarante_rent_3": guaranteRent3,
        "rent_price": rentPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "payment": payment?.toJson(),
        "vehicle_spec": vehicleSpec.toJson(),
      };
}
