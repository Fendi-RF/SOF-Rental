import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:http/http.dart' as http;

import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarsDetails extends StatefulWidget {
  const CarsDetails({Key? key}) : super(key: key);

  @override
  State<CarsDetails> createState() => _CarsDetailsState();
}

class _CarsDetailsState extends State<CarsDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarViewAll(
          size: size,
          themeData: Theme.of(context),
        ),
      ),
      body: CarsFromJsonWidget(),
    );
  }
}

class CarsList extends StatelessWidget {
  const CarsList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            // return ListTile(
            //   title: Text("List item $index"),
            //   trailing: Image.asset('assets/images/golf.png'),
            // );
            return Container(
              height: size.height * 0.1,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Toyota Alpha X-$index',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff3b22a1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 15),
                            color: Colors.black.withOpacity(0.23),
                            blurRadius: 18,
                          )
                        ]),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/golf.png',
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CarsFromJsonWidget extends StatelessWidget {
  const CarsFromJsonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: dioGetCar(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Cars> cars = snapshot.data;
          return buildCarList(cars, size);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Future<List<Cars>> dioGetCar() async {
  // var dio = Dio();
  // final response =
  //     await dio.get('https://ukk-smk-2022.rahmatwahyumaakbar.com/api/vehicles/',
  //         options: Options(headers: {
  //           HttpHeaders.authorizationHeader:
  //               "Bearer 10|5rglV0srLC2UO5KHLf4pIRE83amvIhBbrpzNMiMH"
  //         }));
  // final body = jsonDecode(response.data);
  // return body.map<Cars>(Cars.fromJson).toList();

  final response = await http.get(
      Uri.parse('https://ukk-smk-2022.rahmatwahyumaakbar.com/api/vehicles/'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer 10|5rglV0srLC2UO5KHLf4pIRE83amvIhBbrpzNMiMH"
      });
  final body = jsonDecode(response.body);
  return body.map<Cars>(Cars.fromJson).toList();
}

Widget buildCarList(List<Cars> cars, Size size) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          final car = cars[index];
          return Container(
            height: size.height * 0.1,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        car.vehicleName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff3b22a1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          color: Colors.black.withOpacity(0.23),
                          blurRadius: 18,
                        )
                      ]),
                ),
                Positioned.fill(
                    child: Image.network(
                  car.vehicleImage,
                  alignment: Alignment.centerRight,
                )),
              ],
            ),
          );
        }),
  );
}
