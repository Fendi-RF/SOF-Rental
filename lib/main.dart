import 'package:car_rental_app_ui/data/themes_data.dart';
import 'package:car_rental_app_ui/data/models/user_model.dart';
import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  bool status = true;

  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      title: 'SOF Rental',
      home: LoginPage(),
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = HomePage();
    } else {
      child = LoginPage();
    }

    return Scaffold(
      body: child,
    );
  }
}
