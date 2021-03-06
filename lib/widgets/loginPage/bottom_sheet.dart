import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/user_model.dart';
import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/widgets/registerPage/registVerif.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/http/interface/request_base.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class bottomSheet extends StatefulWidget {
  const bottomSheet({Key? key}) : super(key: key);

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  Register? _register;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController pw = TextEditingController();
  final TextEditingController cpw = TextEditingController();

  bool pwVisible1 = false;
  bool pwVisible2 = false;

  final _formKey = GlobalKey<FormState>();

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
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      height: size.height * 0.9,
      decoration: BoxDecoration(
          color: themeData.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text('Sign Up',
                      style: GoogleFonts.bebasNeue(
                          color: themeData.secondaryHeaderColor, fontSize: 50)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Name';
                      }
                      return null;
                    },
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(UniconsLine.user),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Email is not apropriate';
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(UniconsLine.envelope),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Phone Number';
                      } else if (value.length < 11) {
                        return 'Phone Number is not aproppriate';
                      }
                      return null;
                    },
                    controller: phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(UniconsLine.phone),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Address';
                      } else if (value.length < 8) {
                        return 'Address must be at least 8 characters';
                      }
                      return null;
                    },
                    controller: address,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(UniconsLine.map),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Address',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Password';
                      }
                      return null;
                    },
                    obscureText: !pwVisible1,
                    controller: pw,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        suffixIcon: IconButton(
                            tooltip:
                                !pwVisible1 ? 'Show Password' : 'Hide Password',
                            onPressed: () {
                              setState(() {
                                pwVisible1 = !pwVisible1;
                              });
                            },
                            icon: Icon(pwVisible1
                                ? UniconsLine.eye_slash
                                : UniconsLine.eye)),
                        prefixIcon: Icon(UniconsLine.lock),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Password Confirmation';
                      } else if (value != pw.text) {
                        return 'Password is not the same';
                      }
                      return null;
                    },
                    controller: cpw,
                    obscureText: !pwVisible2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        suffixIcon: IconButton(
                          tooltip:
                              !pwVisible2 ? 'Show Password' : 'Hide Password',
                          onPressed: () =>
                              setState(() => pwVisible2 = !pwVisible2),
                          icon: Icon(pwVisible2
                              ? UniconsLine.eye_slash
                              : UniconsLine.eye),
                        ),
                        prefixIcon: Icon(UniconsLine.lock),
                        fillColor: Colors.white.withOpacity(0.35),
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextButton(
                    child: Text(
                      'Create new Account'.toUpperCase(),
                      style: TextStyle(color: themeData.secondaryHeaderColor),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // final String nameString = name.text;
                        // final String emailString = email.text;
                        // final String phoneString = phone.text;
                        // final String addressString = address.text;
                        // final String pwString = pw.text;
                        // final String cpwString = cpw.text;

                        _registerUser();
                        // Get.to(RegisterVerif(
                        //   email: email.text,
                        // ));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                _register == null
                    ? Container()
                    : Text(
                        'Succesfully created account : ${_register?.name}',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': name.text,
      'email': email.text,
      'phone_number': phone.text,
      'address': address.text,
      'password': pw.text,
      'password_confirmation': cpw.text
    };

    var res = await Network().auth(data, 'register');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      _showMsg(body['message']);
      Get.to(RegisterVerif(
        email: email.text,
      ));
    } else {
      // _showMsg(body['message']);
      // throw "gagal register";
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(body['status']),
                content: Column(
                  children: [
                    Lottie.asset('assets/lottie/cross.json'),
                    Text(body['message'])
                  ],
                ),
              ));
    }

    setState(() {
      _isLoading = false;
    });
  }
}

Future<Register> registerUser(
  String name,
  String email,
  String phoneNumber,
  String address,
  String password,
  String passwordConfirmation,
) async {
  String apiUrl = baseUrl + 'register';

  final response = await http.post(Uri.parse(apiUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,
        'password': password,
        'password_confirmation': passwordConfirmation
      }));

  if (response.statusCode == 201) {
    final responseString = response.body;

    return registerFromJson(responseString);
  } else {
    throw Exception('Failed to create account');
  }
}
