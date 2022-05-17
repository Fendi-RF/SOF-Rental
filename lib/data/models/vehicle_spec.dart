class VehicleSpec {
  VehicleSpec({
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

  factory VehicleSpec.fromJson(Map<String, dynamic> json) => VehicleSpec(
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
      };
}
