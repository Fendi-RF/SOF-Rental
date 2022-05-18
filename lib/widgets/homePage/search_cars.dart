import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarsSearchFromJsonWidget extends StatelessWidget {
  const CarsSearchFromJsonWidget({Key? key, required this.cars})
      : super(key: key);

  final List<Cars> cars;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: cars.map((Cars car) => buildCarList(car, size)).toList(),
    );
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
                // child: Image.network(
                //   baseAssetUrl + cars.vehicleImage,
                //   alignment: Alignment.centerRight,
                // ),
                child: CachedNetworkImage(
                  imageUrl: baseAssetUrl + cars.vehicleImage,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
