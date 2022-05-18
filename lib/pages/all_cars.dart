import 'dart:convert';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/pages/brands_details.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/widgets/about_us.dart';
import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../data/models/cars copy.dart';

class AllCarsPage extends StatefulWidget {
  const AllCarsPage({Key? key}) : super(key: key);

  @override
  State<AllCarsPage> createState() => _AllCarsPageState();
}

class _AllCarsPageState extends State<AllCarsPage> {
  late Future _getCars;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Cars> cars = [];

  @override
  void initState() {
    super.initState();
    _loadApi();
  }

  _loadApi() async {
    _getCars = Request().getCars();

    final cars = await Request().getCars();
    if (mounted) {
      setState(() {
        this.cars = cars;
      });
    }
  }

  void _showDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      drawer: AboutUsDrawer(themeData: themeData),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarMain(
            size: size,
            themeData: themeData,
            iconbutton: IconButton(
              icon: Icon(UniconsLine.info_circle),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            onPressedEnd: _showDialog,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(BrandsDetails());
              },
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Brands_WP.jpeg',
                    height: size.height * 0.1,
                    width: size.width,
                    fit: BoxFit.none,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.47),
                    height: size.height * 0.1,
                  ),
                  Positioned(
                    top: size.height * 0.1 * 0.35,
                    left: size.width * 0.40,
                    child: Text(
                      'Brands',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Text(
              'All Cars',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 25),
            ),
            CarsFromJsonWidget(
              cars: _getCars,
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(1, size, themeData),
      backgroundColor: themeData.backgroundColor,
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Log Out'),
              content: Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    _logout();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('No'),
                )
              ],
            ));
  }

  void _logout() async {
    var response = await Network().logout('logout');
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _showMsg(body['message']);
      Get.off(LoginPage());
    } else {
      _showMsg(body['message']);
    }
  }
}
