import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/user_model.dart';
import 'package:car_rental_app_ui/pages/forget_password.dart';
import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:car_rental_app_ui/widgets/loginPage/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

  @override
  void initState() {
    // TODO: implement initState
    bool _passwordVisible = false;
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController pw = TextEditingController();

  bool pwVisible = false;
  bool _isLoading = false;

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_img.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Container(
              child: Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.23),
                  ),
                  Positioned.fill(
                    left: 20,
                    top: size.height / 4,
                    right: 20,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Image.asset(
                                  'assets/icons/SOF_Rent_White.png'),
                              width: 125,
                              height: 125,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Welcome,'.toUpperCase(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white)),
                            ),
                            Text(greetingMessage(),
                                style: GoogleFonts.rubik(
                                    fontSize: 65, color: Colors.white)),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input Username/Email';
                                  }
                                  return null;
                                },
                                controller: email,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    prefixIcon: Icon(UniconsLine.envelope),
                                    fillColor: Colors.white.withOpacity(0.40),
                                    filled: true,
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextFormField(
                                controller: pw,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input Password';
                                  }
                                  return null;
                                },
                                obscureText: !pwVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    suffixIcon: IconButton(
                                      tooltip: !pwVisible
                                          ? 'Show Password'
                                          : 'Hide Password',
                                      onPressed: () {
                                        setState(() {
                                          pwVisible = !pwVisible;
                                        });
                                      },
                                      icon: Icon(!pwVisible
                                          ? UniconsLine.eye
                                          : UniconsLine.eye_slash),
                                    ),
                                    prefixIcon: Icon(UniconsLine.lock),
                                    fillColor: Colors.white.withOpacity(0.40),
                                    filled: true,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(ResetPassword());
                                },
                                child: Text('Forgot Password?')),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: size.height * 0.01,
                                        ),
                                        child: SizedBox(
                                          height: size.height * 0.07,
                                          width: size.width,
                                          child: InkWell(
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _login();
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color(0xff3b22a1),
                                              ),
                                              child: Align(
                                                child: Text(
                                                  'Login',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    fontSize:
                                                        size.height * 0.025,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                bottomSheet());
                                      },
                                      child: Text('Create a new one'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email.text, 'password': pw.text};

    var res = await Network().auth(data, 'token');
    var body = json.decode(res.body);
    if (res.statusCode == 201) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', jsonEncode(body['token']));
      localStorage.setString('user', json.encode(User.fromJson(body['user'])));
      Network().getToken();
      Get.off(HomePage());
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Good Morning.';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good Afternoon.';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening.';
  } else {
    return 'Good Night.';
  }
}

Align buildSelectButtonFromBrands(
  Size size,
  BuildContext context,
) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.01,
      ),
      child: SizedBox(
        height: size.height * 0.07,
        width: size.width,
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff3b22a1),
            ),
            child: Align(
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
