import 'dart:convert';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/data/models/types.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';

class Request {
  Future<List<Cars>> getCars() async {
    final response = await Network().getData('vehicles');

    if (response.statusCode == 200) {
      return _parseCars(response.body);
    } else {
      throw "Can not connect to the API";
    }
  }

  List<Cars> _parseCars(responseBody) {
    List<dynamic> body = jsonDecode(responseBody);
    List<Cars> cars = body
        .map((dynamic e) => Cars.fromJson(e))
        .where((element) => element.vehicleStatus == 'Available')
        .toList()
      ..sort(((a, b) => a.vehicleName.compareTo(b.vehicleName)));
    return cars;
  }

  Future<List<Types>> getTypes() async {
    final response = await Network().getData('types?limit=4');

    if (response.statusCode == 200) {
      return _parseType(response.body);
    } else {
      throw "Can not connect to the API";
    }
  }

  List<Types> _parseType(responseBody) {
    List<dynamic> body = jsonDecode(responseBody);
    List<Types> type = body.map((dynamic item) => Types.fromJson(item)).toList()
      ..sort(((a, b) => a.typeName.compareTo(b.typeName)));
    return type;
  }

  Future<List<Cars>> getCarsSearch(String query) async {
    final response = await Network().getData('vehicles');

    if (response.statusCode == 200) {
      return _parseCarsSearch(response.body, query);
    } else {
      throw "Can not connect to the API";
    }
  }

  List<Cars> _parseCarsSearch(responseBody, String query) {
    List<dynamic> body = jsonDecode(responseBody);
    List<Cars> cars =
        body.map((dynamic e) => Cars.fromJson(e)).where((element) {
      final nameLower = element.vehicleName.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();
    return cars;
  }

  Future<List<VehicleSpec>> getCarsBrand(String brandName) async {
    final response = await Network().getData('brand/$brandName');

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<VehicleSpec> cars = body['vehicle_spec']
          .map<VehicleSpec>((dynamic item) => VehicleSpec.fromJson(item))
          .toList()
        ..sort((VehicleSpec a, VehicleSpec b) =>
            a.vehicleName.compareTo(b.vehicleName));
      return cars;
    } else {
      throw "Can not connect to the API";
    }
  }

  Future<dynamic> getInvoice() async {
    final res = await Network().getData('payments');
    var body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<Invoice> inv = body
          .map<Invoice>((dynamic i) => Invoice.fromJson(i))
          .where((e) => e.payment.id == null)
          .toList()
        ..sort((Invoice b, Invoice a) => a.createdAt.compareTo(b.createdAt));
      ;
      return inv;
    } else {
      throw "Can not connect to the API";
    }
  }

  Future<dynamic> getHistory() async {
    final res = await Network().getData('payments');
    var body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<Invoice> inv = body
          .map<Invoice>((dynamic i) => Invoice.fromJson(i))
          .where((element) => element.payment.id != null)
          .toList()
        ..sort((Invoice b, Invoice a) => a.createdAt.compareTo(b.createdAt));
      return inv;
    } else {
      throw "Can not connect to the API";
    }
  }
}
