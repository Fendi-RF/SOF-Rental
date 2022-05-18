import 'dart:ffi';

import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({
    Key? key,
    required this.themeData,
    required this.size,
    required this.iconbutton,
    required this.onPressedEnd,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;
  final IconButton iconbutton;
  final VoidCallback onPressedEnd;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: themeData.secondaryHeaderColor),
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      // automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Image.asset(
          themeData.brightness == Brightness.dark
              ? 'assets/icons/SOF_Rent_White.png'
              : 'assets/icons/SOF_Rent_SemiBlack.png', //logo
          height: size.height * 0.12),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.05,
          ),
          child: SizedBox(
            height: size.width * 0.1,
            width: size.width * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: themeData.backgroundColor.withOpacity(0.03),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  UniconsLine.exit,
                  color: themeData.secondaryHeaderColor,
                  size: size.height * 0.025,
                ),
                onPressed: () {
                  onPressedEnd();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarDetail extends StatelessWidget {
  const AppBarDetail({
    Key? key,
    required this.themeData,
    required this.size,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

class AppBarViewAll extends StatefulWidget {
  const AppBarViewAll({
    Key? key,
    required this.themeData,
    required this.size,
    required this.integer1,
    required this.integer2,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;
  final int integer1;
  final int integer2;

  @override
  State<AppBarViewAll> createState() => _AppBarViewAllState();
}

class _AppBarViewAllState extends State<AppBarViewAll> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: widget.themeData.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: widget.size.width * 0.05,
        ),
        child: SizedBox(
          height: widget.size.width * 0.01,
          width: widget.size.width * 0.1,
          child: InkWell(
            onTap: () {
              Get.back(); //go back to home page
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.themeData.cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                UniconsLine.multiply,
                color: widget.themeData.secondaryHeaderColor,
                size: widget.size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: widget.size.width * 0.15,
      title: Image.asset(
        widget.themeData.brightness == Brightness.dark
            ? 'assets/icons/SOF_Rent_White.png'
            : 'assets/icons/SOF_Rent_Black.png',
        height: widget.size.height * 0.12,
        width: widget.size.width * 0.35,
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
            onPressed: () {})
      ],
    );
  }
}

class AppBarText extends StatelessWidget {
  const AppBarText({
    Key? key,
    required this.themeData,
    required this.size,
    required this.textTitle,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;
  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        child: SizedBox(
          height: size.width * 0.2,
          width: size.width * 0.2,
          child: Container(
            decoration: BoxDecoration(
              color: themeData.backgroundColor.withOpacity(0.03),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Text(textTitle.toUpperCase(),
          style: GoogleFonts.bebasNeue(
              color: themeData.secondaryHeaderColor,
              fontSize: size.height * 0.05)),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.05,
          ),
          child: SizedBox(
            height: size.width * 0.1,
            width: size.width * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: themeData.backgroundColor.withOpacity(0.03),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                UniconsLine.exit,
                color: themeData.secondaryHeaderColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
