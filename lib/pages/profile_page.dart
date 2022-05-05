import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
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
      bottomNavigationBar: buildBottomNavBar(2, size, themeData),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                ),
                Text('loren ipsum')
              ],
            ),
          )
        ],
      ),
    );
  }
}
