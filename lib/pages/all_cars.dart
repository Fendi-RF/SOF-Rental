import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllCarsPage extends StatefulWidget {
  const AllCarsPage({Key? key}) : super(key: key);

  @override
  State<AllCarsPage> createState() => _AllCarsPageState();
}

class _AllCarsPageState extends State<AllCarsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarText(
          size: size,
          themeData: themeData,
          textTitle: 'Vehicles',
        ),
      ),
      body: CarsFromJsonWidget(),
      bottomNavigationBar: buildBottomNavBar(1, size, themeData),
      backgroundColor: themeData.backgroundColor,
    );
  }
}
