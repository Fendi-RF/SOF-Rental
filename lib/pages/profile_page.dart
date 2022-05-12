import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      bottomNavigationBar: buildBottomNavBar(2, size, themeData),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              color: themeData.cardColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    child: Text('SOF'),
                    radius: 35,
                  ),
                ),
                Text('Users')
              ],
            ),
          ),
          buildCategory('Activity Status', size, themeData, () {}),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text('There is no activity'),
            ),
          ),
          buildCategory('Recent History', size, themeData, () {}),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text('There is no history'),
            ),
          )
        ],
      ),
    );
  }
}
