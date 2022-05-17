import 'dart:convert';

import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarsBrandDetails extends StatefulWidget {
  const CarsBrandDetails({Key? key, required this.brandName}) : super(key: key);

  final String brandName;

  @override
  State<CarsBrandDetails> createState() => _CarsBrandDetailsState();
}

class _CarsBrandDetailsState extends State<CarsBrandDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBarDetail(
            size: size,
            themeData: themeData,
          )),
      body: CarsBrandFromJsonWidget(brandName: widget.brandName),
    );
  }
}

class CarsBrandFromJsonWidget extends StatelessWidget {
  const CarsBrandFromJsonWidget({Key? key, required this.brandName})
      : super(key: key);

  final String brandName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: Request().getCarsBrand(brandName),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<VehicleSpec> cars = snapshot.data;
          return ListView(
            children: cars
                .map((VehicleSpec car) => buildCarListFromBrands(car, size))
                .toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
