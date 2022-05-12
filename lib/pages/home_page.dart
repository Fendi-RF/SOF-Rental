import 'dart:convert';
// import 'dart:html';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:car_rental_app_ui/data/cars%20copy.dart';
import 'package:car_rental_app_ui/data/cars.dart';
import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';

import 'package:car_rental_app_ui/widgets/homePage/most_rented.dart';
import 'package:car_rental_app_ui/widgets/homePage/top_brands.dart';
import 'package:flutter/material.dart';
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
  late List<Cars> cars;
  String query = '';
  String name = '';

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());
    Network().token = jsonDecode(localStorage.getString('token').toString());

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);

    Future _getBrand;
    Future _getCars;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), //appbar size
        child: AppBarMain(themeData: themeData, size: size),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavBar(0, size, themeData),
      backgroundColor: themeData.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            try {
              await Network().getData('brands?limit=4');
              await Network().getData('type?limit=4');
              await Network().getData('vehicles');
            } catch (e) {
              throw 'Exception';
            }
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
                            'With Corporate Difference',
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
                            'Enjoy the fun driving in Enterprise',
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
                          left: size.width * 0.04,
                          bottom: size.height * 0.025,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.65,
                              height: size.height * 0.06,
                              child: TextField(
                                onChanged: searchCar,
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
                            Padding(
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
                                  color: Color(0xff3b22a1), //filters bg color
                                ),
                                child: Icon(
                                  UniconsLine.search,
                                  color: Colors.white,
                                  size: size.height * 0.032,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // controller.text != ''
              //     ? CarsSearch(
              //         query: controller.text,
              //       )
              //     :
              buildTopBrandsWithJson(size, themeData),
              buildCategory('Vehicle Types', size, themeData, () {}),
              VehicleTypes(size: size, themeData: themeData),
              buildMostRented(size, themeData),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (CircleAvatar(
                      child: Text('D'),
                    )),
                  ),
                  Text('Data DATA Data DATA Data DATA Data DATA')
                ],
              ),
              decoration: BoxDecoration(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  Future searchCar(String query) async {
    final cars = await getCarsSearch(controller.text);
    if (!mounted) return;

    setState(() {
      this.query = controller.text;
      this.cars = cars;
    });
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
}

class VehicleTypes extends StatelessWidget {
  const VehicleTypes({
    Key? key,
    required this.size,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTypes(),
        builder: (BuildContext buildContext, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Type> type = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: type
                  .map((Type e) => buildTypesFromJson(size, themeData, e))
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Future<List<Type>> getTypes() async {
  final response = await Network().getData('types?limit=4');

  if (response.statusCode == 200) {
    return parseType(response.body);
  } else {
    throw "Can not connect to the API";
  }
}

List<Type> parseType(responseBody) {
  List<dynamic> body = jsonDecode(responseBody);
  List<Type> type = body.map((dynamic item) => Type.fromJson(item)).toList()
    ..sort(((a, b) => a.typeName.compareTo(b.typeName)));
  return type;
}

Padding buildTypesFromJson(Size size, ThemeData themeData, Type type) {
  IconData icon;
  switch (type.typeName) {
    case 'Motorcycle':
      icon = UniconsLine.car_slash;
      break;
    case 'Car':
      icon = UniconsLine.car;
      break;
    case 'Bicyle':
      icon = UniconsLine.car_slash;
      break;
    default:
      icon = UniconsLine.lock;
  }
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03, vertical: size.width * 0.05),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: size.width * 0.18,
        width: size.width * 0.18,
        child: Container(
          child: Icon(icon),
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
