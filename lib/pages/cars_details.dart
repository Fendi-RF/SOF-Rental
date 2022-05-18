import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';
import 'package:car_rental_app_ui/pages/details_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CarsDetails extends StatefulWidget {
  const CarsDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CarsDetails> createState() => _CarsDetailsState();
}

class _CarsDetailsState extends State<CarsDetails> {
  late Future _getCars;

  @override
  void initState() {
    super.initState();
    _loadApi();
  }

  _loadApi() async {
    _getCars = Request().getCars();
  }

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
        ),
      ),
      body: CarsFromJsonWidget(
        cars: _getCars,
      ),
      backgroundColor: themeData.backgroundColor,
    );
  }
}

int sort = 1;

class CarsFromJsonWidget extends StatelessWidget {
  const CarsFromJsonWidget({Key? key, required this.cars}) : super(key: key);

  final Future cars;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: cars,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Cars> cars = snapshot.data;
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: cars.map((Cars car) => buildCarList(car, size)).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Future<List<Cars>> _getCars() async {
  final response = await Network().getData('vehicles/');

  if (response.statusCode == 200) {
    return parseCars(response.body);
  } else {
    throw "Can not connect to the API";
  }
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
              child: CachedNetworkImage(
                imageUrl: baseAssetUrl + cars.vehicleImage,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                alignment: Alignment.centerRight,
              ),
              // child: Image.network(
              //   baseAssetUrl + cars.vehicleImage,
              //   alignment: Alignment.centerRight,
              // ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildCarListFromBrands(VehicleSpec cars, Size size) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Get.to(DetailsPageFromBrands(cars: cars));
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
              child: CachedNetworkImage(
                imageUrl: baseAssetUrl + cars.vehicleImage,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                alignment: Alignment.centerRight,
              ),
              // child: Image.network(
              //   baseAssetUrl + cars.vehicleImage,
              //   alignment: Alignment.centerRight,
              // ),
            ),
          ],
        ),
      ),
    ),
  );
}
