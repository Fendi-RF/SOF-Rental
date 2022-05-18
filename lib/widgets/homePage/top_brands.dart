import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/brands_details.dart';
import 'package:car_rental_app_ui/widgets/homePage/brand_logo.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Column buildTopBrandsWithJson(Size size, ThemeData themeData, Future brands) {
  return Column(
    children: [
      buildCategory('Top Brands', size, themeData, () {
        Get.to(BrandsDetails());
      }),
      TopBrandJson(
        size: size,
        themeData: themeData,
        brands: brands,
      ),
    ],
  );
}

class TopBrandJson extends StatelessWidget {
  const TopBrandJson({
    Key? key,
    required this.size,
    required this.themeData,
    required this.brands,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final Future<dynamic> brands;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.001),
      child: FutureBuilder(
        future: brands,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Brands> brands = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: brands
                  .map((Brands brand) => buildBrandLogofromJson(
                      // Image.network(
                      //   baseAssetUrl + brand.brandImage,
                      //   height: size.height * 0.05,
                      // )
                      CachedNetworkImage(
                        imageUrl: baseAssetUrl + brand.brandImage,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
    List<Brands> brands = body
        .map((dynamic item) => Brands.fromJson(item))
        .toList()
      ..sort(((a, b) => a.brandName.compareTo(b.brandName)));
    return brands;
  } else {
    throw "Can not connect to the API";
  }
}
