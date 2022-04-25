import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: AppBarViewAll(
          size: size,
          themeData: themeData,
        ),
      ),
      body: Padding(
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
      ),
    );
  }
}
