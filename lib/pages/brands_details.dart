import 'dart:convert';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class Brands extends StatefulWidget {
  const Brands({Key? key}) : super(key: key);

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarDetail(
          size: size,
          themeData: themeData,
        ),
      ),
      body: BrandsFromJsonWidget(),
    );
  }
}

class BrandsPlaceholder extends StatelessWidget {
  const BrandsPlaceholder({
    Key? key,
    required this.size,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          buildBrandLogowithText(
              Image.asset(
                'assets/icons/hyundai.png',
                height: size.width * 0.1,
                width: size.width * 0.15,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
              'Hyundai'),
          buildBrandLogowithText(
              Image.asset(
                'assets/icons/volkswagen.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
              'Volkswagen'),
          buildBrandLogowithText(
              Image.asset(
                'assets/icons/toyota.png',
                height: size.width * 0.08,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
              'Toyota'),
          buildBrandLogowithText(
              Image.asset(
                'assets/icons/bmw.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              themeData,
              ''),
        ],
      ),
    );
  }
}

Future<List<Brand>> getBrands() async {
  final response = await Network().getData('brands');

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

class BrandsFromJsonWidget extends StatelessWidget {
  const BrandsFromJsonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return FutureBuilder(
      future: getBrands(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Brand> brands = snapshot.data;
          return GridView.count(
            crossAxisCount: 2,
            children: brands
                .map((Brand brand) => buildBrandLogowithTextfromJson(
                    Image.network(
                      baseAssetUrl + brand.brandImage,
                      height: size.height * 0.1,
                    ),
                    size,
                    themeData,
                    brand.brandName,
                    brand))
                .toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
