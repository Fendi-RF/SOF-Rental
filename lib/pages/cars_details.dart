import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/details_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CarsDetails extends StatefulWidget {
  const CarsDetails({Key? key}) : super(key: key);

  @override
  State<CarsDetails> createState() => _CarsDetailsState();
}

class _CarsDetailsState extends State<CarsDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: themeData.backgroundColor,
          leading: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: SizedBox(
              height: size.width * 0.01,
              width: size.width * 0.1,
              child: InkWell(
                onTap: () {
                  Get.back(); //go back to home page
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.cardColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    UniconsLine.multiply,
                    color: themeData.secondaryHeaderColor,
                    size: size.height * 0.025,
                  ),
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Image.asset(
            themeData.brightness == Brightness.dark
                ? 'assets/icons/SOF_Rent_White.png'
                : 'assets/icons/SOF_Rent_Black.png',
            height: size.height * 0.12,
            width: size.width * 0.35,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                UniconsLine.search_alt,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(
                  UniconsLine.sort,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                onPressed: () {
                  setState(() {
                    sort = 1;
                  });
                })
          ],
        ),
      ),
      body: CarsFromJsonWidget(),
      backgroundColor: themeData.backgroundColor,
    );
  }
}

int sort = 1;

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

class CarsSearch extends StatelessWidget {
  const CarsSearch({Key? key, this.query}) : super(key: key);
  final String? query;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getCarsSearch(query!),
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

Future<List<Cars>> getCars() async {
  final response = await Network().getData('vehicles/');

  if (response.statusCode == 200) {
    return parseCars(response.body);
  } else {
    throw "Can not connect to the API";
  }
}

Future<List<Cars>> getCarsSearch(String query) async {
  final response = await Network().getData('vehicles/');

  if (response.statusCode == 200) {
    return parseCarsSearch(response.body, query);
  } else {
    throw "Can not connect to the API";
  }
}

List<Cars> parseCarsSearch(String responseBody, String query) {
  List<dynamic> body = jsonDecode(responseBody);
  List<Cars> cars =
      body.map((dynamic item) => Cars.fromJson(item)).where((car) {
    final carLower = car.vehicleName.toLowerCase();
    final searchLower = query.toLowerCase();

    return carLower.contains(searchLower);
  }).toList()
        ..sort(((a, b) => a.vehicleName.compareTo(b.vehicleName)));
  return cars;
}

List<Cars> parseCars(String responseBody) {
  List<dynamic> body = jsonDecode(responseBody);
  List<Cars> cars = body.map((dynamic item) => Cars.fromJson(item)).toList()
    ..sort(((a, b) => a.vehicleName.compareTo(b.vehicleName)));
  return cars;
}

Widget buildCarList(Cars cars, Size size) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Get.to(DetailsPage(cars: cars));
      },
      child: Container(
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
                    cars.vehicleName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              height: size.height * 0.1,
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
                baseAssetUrl + cars.vehicleImage,
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<List<Cars>> getCarsBrand(String brandName) async {
  final response = await http.get(Uri.parse(baseUrl + 'brands/' + brandName),
      headers: {"Accept": "application/json", "Authorization": apiBearerToken});

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Cars> cars = body.map((dynamic item) => Cars.fromJson(item)).toList()
      ..sort(((a, b) => a.vehicleName.compareTo(b.vehicleName)));
    return cars;
  } else {
    throw "Can not connect to the API";
  }
}
