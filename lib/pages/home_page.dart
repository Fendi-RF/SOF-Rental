import 'dart:convert';
// import 'dart:html';
// import 'dart:html';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/cars.dart';
import 'package:car_rental_app_ui/data/models/user_model.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';

import 'package:car_rental_app_ui/widgets/homePage/most_rented.dart';
import 'package:car_rental_app_ui/widgets/homePage/search_cars.dart';
import 'package:car_rental_app_ui/widgets/homePage/top_brands.dart';
import 'package:car_rental_app_ui/widgets/homePage/vehicle_types.dart';
import 'package:car_rental_app_ui/widgets/sort_by.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../widgets/app_bar.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '';
  List<Cars> cars = [];

  List<Cars> carsSearch = [];

  late Future<List<dynamic>> _getBrand;
  late Future<List<dynamic>> _getCars;
  late Future<List<dynamic>> _getTypes;

  final TextEditingController controller = TextEditingController();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadApi();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var map = jsonDecode(localStorage.getString('user') ?? '');
    Network().token = jsonDecode(localStorage.getString('token').toString());
    User user = User.fromJson(map);
    print(user.avatar);
  }

  _loadApi() async {
    _getBrand = getBrands();
    _getCars = Request().getCars();
    _getTypes = Request().getTypes();

    final cars = await Request().getCars();

    if (mounted) {
      setState(() {
        this.cars = cars;
      });
    }
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), //appbar size
        child: AppBarMain(
            themeData: themeData, size: size, onPressed: _showDialog),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavBar(0, size, themeData),
      backgroundColor: themeData.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 15));
            setState(() {
              _loadApi();
            });
          },
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: themeData.cardColor, //section bg color
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.04,
                        ),
                        child: Align(
                          child: Text(
                            'Fast & Easy To Rent A Car',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: themeData.secondaryHeaderColor,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                        ),
                        child: Align(
                          child: Text(
                            'Source of fortune for everyone',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: themeData.secondaryHeaderColor,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.025,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.65,
                              height: size.height * 0.06,
                              child: Expanded(
                                child: TextField(
                                  onChanged: (val) {
                                    setState(() {
                                      if (val != '') {
                                        _isSearching = true;
                                      } else {
                                        _isSearching = false;
                                      }

                                      carsSearch = cars
                                          .where((element) => (element
                                              .vehicleName
                                              .toLowerCase()
                                              .contains(val.toLowerCase())))
                                          .toList();
                                    });
                                  },
                                  controller: controller,
                                  // onChanged: (value) => final suh,
                                  //searchbar
                                  style: GoogleFonts.poppins(
                                    color: themeData.primaryColor,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      left: size.width * 0.04,
                                      right: size.width * 0.04,
                                    ),
                                    enabledBorder: textFieldBorder(),
                                    focusedBorder: textFieldBorder(),
                                    border: textFieldBorder(),
                                    hintStyle: GoogleFonts.poppins(
                                      color: themeData.primaryColor,
                                    ),
                                    hintText: 'Search a car',
                                  ),
                                ),
                              ),
                            ),
                            _isSearching
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.025,
                                    ),
                                    child: Container(
                                      height: size.height * 0.06,
                                      width: size.width * 0.14,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Color(
                                            0xff3b22a1), //filters bg color
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          UniconsLine.filter,
                                          color: Colors.white,
                                          size: size.height * 0.032,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) => SortBy());
                                        },
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _isSearching
                  ? CarsSearchFromJsonWidget(cars: carsSearch)
                  : Recommendation(size, themeData),
            ],
          ),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: (CircleAvatar(
      //                 child: Text('D'),
      //               )),
      //             ),
      //             Text('Data DATA Data DATA Data DATA Data DATA')
      //           ],
      //         ),
      //         decoration: BoxDecoration(color: Colors.blue),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }

  Future searchCars(String query) async {
    final suggestions = await Request().getCarsSearch(query);
    if (!mounted) return;

    setState(() {
      _isSearching = true;
      this.query = query;
      cars = suggestions;
    });
  }

  Column Recommendation(Size size, ThemeData themeData) {
    return Column(
      children: [
        buildTopBrandsWithJson(size, themeData, _getBrand),
        // buildTypes(size, themeData, _getTypes),
        buildMostRented(size, themeData, _getCars),
      ],
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
                    )),
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
