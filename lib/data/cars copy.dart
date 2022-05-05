// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Cars loginFromJson(String str) => Cars.fromJson(json.decode(str));

String loginToJson(Cars data) => json.encode(data.toJson());

class Cars {
  Cars({
    required this.id,
    required this.idType,
    required this.idBrand,
    required this.vehicleName,
    required this.vehicleSlug,
    required this.numberPlate,
    required this.vehicleImage,
    required this.vehicleYear,
    required this.vehicleColor,
    required this.vehicleSeats,
    required this.vehicleStatus,
    required this.rentPrice,
    required this.vehicleDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.rental,
    required this.brand,
  });

  int id;
  String idType;
  String idBrand;
  String vehicleName;
  String vehicleSlug;
  String numberPlate;
  String vehicleImage;
  String vehicleYear;
  String vehicleColor;
  String vehicleSeats;
  String vehicleStatus;
  String rentPrice;
  String vehicleDescription;
  DateTime createdAt;
  DateTime updatedAt;
  Type type;
  List<dynamic> rental;
  Brand brand;

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        id: json["id"],
        idType: json["id_type"],
        idBrand: json["id_brand"],
        vehicleName: json["vehicle_name"],
        vehicleSlug: json["vehicle_slug"],
        numberPlate: json["number_plate"],
        vehicleImage: json["vehicle_image"],
        vehicleYear: json["vehicle_year"],
        vehicleColor: json["vehicle_color"],
        vehicleSeats: json["vehicle_seats"],
        vehicleStatus: json["vehicle_status"],
        rentPrice: json["rent_price"],
        vehicleDescription: json["vehicle_description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: Type.fromJson(json["type"]),
        rental: List<dynamic>.from(json["rental"].map((x) => x)),
        brand: Brand.fromJson(json["brand"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_type": idType,
        "id_brand": idBrand,
        "vehicle_name": vehicleName,
        "vehicle_slug": vehicleSlug,
        "number_plate": numberPlate,
        "vehicle_image": vehicleImage,
        "vehicle_year": vehicleYear,
        "vehicle_color": vehicleColor,
        "vehicle_seats": vehicleSeats,
        "vehicle_status": vehicleStatus,
        "rent_price": rentPrice,
        "vehicle_description": vehicleDescription,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type.toJson(),
        "rental": List<dynamic>.from(rental.map((x) => x)),
        "brand": brand.toJson(),
      };
}

class Brand {
  Brand({
    required this.id,
    required this.typeId,
    required this.brandName,
    required this.brandSlug,
    required this.brandImage,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String typeId;
  String brandName;
  String brandSlug;
  String brandImage;
  DateTime createdAt;
  DateTime updatedAt;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        typeId: json["type_id"],
        brandName: json["brand_name"],
        brandSlug: json["brand_slug"],
        brandImage: json["brand_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "brand_name": brandName,
        "brand_slug": brandSlug,
        "brand_image": brandImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Type {
  Type({
    required this.id,
    required this.typeName,
    required this.typeSlug,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String typeName;
  String typeSlug;
  DateTime createdAt;
  DateTime updatedAt;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        typeName: json["type_name"],
        typeSlug: json["type_slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_name": typeName,
        "type_slug": typeSlug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
