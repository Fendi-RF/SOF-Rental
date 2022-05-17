// To parse this JSON data, do
//
//     final brands = brandsFromJson(jsonString);

import 'package:car_rental_app_ui/data/models/types.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Brands brandsFromJson(String str) => Brands.fromJson(json.decode(str));

String brandsToJson(Brands data) => json.encode(data.toJson());

class Brands {
  Brands({
    required this.id,
    required this.typeId,
    required this.brandName,
    required this.brandSlug,
    required this.brandImage,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.vehicleSpec,
  });

  int id;
  String typeId;
  String brandName;
  String brandSlug;
  String brandImage;
  DateTime createdAt;
  DateTime updatedAt;
  Types type;
  List<VehicleSpec> vehicleSpec;

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
        id: json["id"],
        typeId: json["type_id"],
        brandName: json["brand_name"],
        brandSlug: json["brand_slug"],
        brandImage: json["brand_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: Types.fromJson(json["type"]),
        vehicleSpec: List<VehicleSpec>.from(
            json["vehicle_spec"].map((x) => VehicleSpec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "brand_name": brandName,
        "brand_slug": brandSlug,
        "brand_image": brandImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type.toJson(),
        "vehicle_spec": List<dynamic>.from(vehicleSpec.map((x) => x.toJson())),
      };
}
