import 'dart:convert';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class BrandsDetails extends StatefulWidget {
  const BrandsDetails({Key? key}) : super(key: key);

  @override
  State<BrandsDetails> createState() => _BrandsDetailsState();
}

class _BrandsDetailsState extends State<BrandsDetails> {
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

Future<List<Brands>> getBrands() async {
  final response = await Network().getData('brands');

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
          List<Brands> brands = snapshot.data;
          return GridView.count(
            crossAxisCount: 2,
            children: brands
                .map((Brands brand) => buildBrandLogofromJson(
                    Image.network(
                      baseAssetUrl + brand.brandImage,
                      height: size.height * 0.1,
                    ),
                    size,
                    themeData,
                    brand))
                .toList(),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: themeData.secondaryHeaderColor,
          ));
        }
      },
    );
  }
}
