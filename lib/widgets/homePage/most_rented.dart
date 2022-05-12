import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/data/cars.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/widgets/homePage/car.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildMostRented(Size size, ThemeData themeData) {
  return Column(
    children: [
      buildCategory('Most Rented', size, themeData, () {
        Get.to(CarsDetails());
      }),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        child: SizedBox(
          height: size.width * 0.55,
          width: size.width,
          child: FutureBuilder(
            future: getCars(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<Cars> cars = snapshot.data;
                return ListView(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: cars
                        .map((Cars car) =>
                            buildCarWithJson(size, themeData, car))
                        .toList());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    ],
  );
}

Future<List<Cars>> getCars() async {
  final response = await Network().getData('vehicles');

  if (response.statusCode == 200) {
    return parseCars(response.body);
  } else {
    throw "Can not connect to the API";
  }
}

List<Cars> parseCars(responseBody) {
  List<dynamic> body = jsonDecode(responseBody);
  List<Cars> cars = body.map((dynamic e) => Cars.fromJson(e)).toList();
  return cars;
}

class CarsFromJsonWidget extends StatelessWidget {
  const CarsFromJsonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getCars(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Cars> cars = snapshot.data;
          return ListView(
            children: cars.map((Cars car) => buildCarList(car, size)).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
