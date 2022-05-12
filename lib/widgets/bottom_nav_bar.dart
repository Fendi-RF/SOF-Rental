import 'package:car_rental_app_ui/pages/all_cars.dart';
import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:car_rental_app_ui/pages/profile_page.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

Widget buildBottomNavBar(int currIndex, Size size, ThemeData themeData) {
  return BottomNavigationBar(
    iconSize: size.width * 0.07,
    elevation: 0,
    selectedLabelStyle: const TextStyle(fontSize: 0),
    unselectedLabelStyle: const TextStyle(fontSize: 0),
    currentIndex: currIndex,
    backgroundColor: const Color(0x00ffffff),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: themeData.brightness == Brightness.dark
        ? Colors.indigoAccent
        : Colors.black,
    unselectedItemColor: const Color(0xff3b22a1),
    onTap: (value) {
      if (value != currIndex) {
        if (value == 0) {
          Get.off(const HomePage(), transition: Transition.noTransition);
        } else if (value == 1) {
          Get.off(AllCarsPage(), transition: Transition.noTransition);
          // TODO : make a Cars page
        } else {
          Get.off(ProfilePage(), transition: Transition.noTransition);
          // TODO : make a profile/dashboard page
        }
      }
    },
    items: [
      buildBottomNavItem(
        UniconsLine.home,
        themeData,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.car_sideview,
        themeData,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.user,
        themeData,
        size,
      ),
    ],
  );
}
