import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/cars_brand_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding buildBrandLogo(Widget image, Size size, ThemeData themeData) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.03,
    ),
    child: SizedBox(
      height: size.width * 0.18,
      width: size.width * 0.18,
      child: Container(
        decoration: BoxDecoration(
          color: themeData.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Center(
          child: image,
        ),
      ),
    ),
  );
}

Padding buildBrandLogowithText(
    Widget image, Size size, ThemeData themeData, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.03,
    ),
    child: SizedBox(
      height: size.width * 0.18,
      width: size.width * 0.18,
      child: Container(
        decoration: BoxDecoration(
          color: themeData.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [image, Text(text)]),
      ),
    ),
  );
}

Padding buildBrandLogowithTextfromJson(
    Widget image, Size size, ThemeData themeData, String text, Brand brand) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03, vertical: size.width * 0.05),
    child: GestureDetector(
      onTap: () {
        Get.to(CarsBrandDetails(brandName: brand.brandSlug));
      },
      child: SizedBox(
        height: size.width * 0.18,
        width: size.width * 0.18,
        child: Container(
          decoration: BoxDecoration(
            color: themeData.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [image, Text(text)]),
        ),
      ),
    ),
  );
}

Padding buildBrandLogofromJson(
    Widget image, Size size, ThemeData themeData, Brand brand) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03, vertical: size.width * 0.05),
    child: GestureDetector(
      onTap: () {
        Get.to(CarsBrandDetails(brandName: brand.brandSlug));
      },
      child: SizedBox(
        height: size.width * 0.18,
        width: size.width * 0.18,
        child: Container(
          child: image,
          decoration: BoxDecoration(
            color: themeData.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
