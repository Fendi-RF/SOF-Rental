import 'dart:convert';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/brands_details.dart';
import 'package:car_rental_app_ui/widgets/homePage/brand_logo.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Column buildTopBrands(Size size, ThemeData themeData) {
  return Column(
    children: [
      buildCategory('Top Brands', size, themeData, () {
        Get.to(Brands());
      }),
      Padding(
        padding: EdgeInsets.only(top: size.height * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBrandLogo(
              Image.asset(
                'assets/icons/hyundai.png',
                height: size.width * 0.1,
                width: size.width * 0.15,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/volkswagen.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/toyota.png',
                height: size.width * 0.08,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/bmw.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
            ),
          ],
        ),
      ),
    ],
  );
}

Column buildTopBrandsWithJson(Size size, ThemeData themeData) {
  return Column(
    children: [
      buildCategory('Top Brands', size, themeData, () {
        Get.to(Brands());
      }),
      TopBrandJson(
        size: size,
        themeData: themeData,
      ),
    ],
  );
}

class TopBrandJson extends StatelessWidget {
  const TopBrandJson({
    Key? key,
    required this.size,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.015),
      child: FutureBuilder(
        future: getBrands(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Brand> brands = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: brands
                  .map((Brand brand) => buildBrandLogofromJson(
                      Image.network(
                        baseAssetUrl + brand.brandImage,
                        height: size.height * 0.05,
                      ),
                      size,
                      themeData,
                      brand))
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<dynamic>> getBrands() async {
  final response = await Network().getData('brands?limit=4');

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Brand> brands = body
        .map((dynamic item) => Brand.fromJson(item))
        .toList()
      ..sort(((a, b) => a.brandName.compareTo(b.brandName)));
    return brands;
  } else {
    throw "Can not connect to the API";
  }
}
