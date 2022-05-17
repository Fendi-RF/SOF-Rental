import 'dart:math';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/cars.dart';
import 'package:car_rental_app_ui/pages/details_page.dart';
import 'package:car_rental_app_ui/widgets/carDetailsPage/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

Padding buildCarWithJson(
    Size size, ThemeData themeData, Cars cars, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      right: size.width * 0.03,
    ),
    child: Center(
      child: SizedBox(
        height: size.width * 0.55,
        width: size.width * 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: themeData.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.02,
            ),
            child: InkWell(
              onTap: () {
                Get.to(DetailsPage(cars: cars));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          baseAssetUrl + cars.vehicleImage,
                          height: size.width * 0.25,
                          width: size.width * 0.5,
                          fit: BoxFit.contain,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    child: Text(
                      cars.vehicleYear,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: themeData.secondaryHeaderColor,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    cars.vehicleName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: themeData.secondaryHeaderColor,
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(children: [
                    RichText(
                      text: TextSpan(
                          text: 'Rp${cars.rentPrice}\n',
                          style: GoogleFonts.poppins(
                            color: themeData.secondaryHeaderColor,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '/per day',
                              style: GoogleFonts.poppins(
                                color: themeData.primaryColor.withOpacity(0.8),
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.025,
                      ),
                      child: SizedBox(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff3b22a1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              UniconsLine.credit_card,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => TransactionForm(
                                        cars: cars,
                                      ));
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
