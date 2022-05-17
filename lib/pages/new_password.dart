import 'dart:convert';

import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../data/API/api_url.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({Key? key, required this.otp}) : super(key: key);

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();

  final String otp;
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String? pw;
  String? cpw;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        color: themeData.backgroundColor,
        child: Column(children: [
          Text(
            'Enter New Password',
            style: GoogleFonts.bebasNeue(
                fontSize: 35, color: themeData.primaryColor),
          ),
          Text(
            'Enter your new password. Password can be the same as previous.',
            style: TextStyle(color: themeData.primaryColor),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(UniconsLine.lock),
                      hintText: 'New Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter a password';
                    } else if (v.length < 5) {
                      return 'Password at least need to be 5 char length';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    setState(() {
                      pw = v;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(UniconsLine.lock),
                      hintText: 'Confirm New Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter a password';
                    } else if (v.length < 5) {
                      return 'Password at least need to be 5 char length';
                    } else if (v != pw) {
                      return 'Password Confirmation is not the same';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    setState(() {
                      cpw = v;
                    });
                  },
                ),
              ],
            ),
          ),
          Spacer(),
          _isLoading
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
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // _verifyAcc;
                            _newPW();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff3b22a1),
                          ),
                          child: Align(
                            child: Text(
                              'Confirm',
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
                ),
        ]),
      ),
    );
  }

  void _newPW() async {
    setState(() {
      _isLoading = true;
    });

    var data = {'password': pw, 'password_confirmation': cpw};

    var res = await Network().auth(data, 'reset/${widget.otp}');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(body['status']),
          content: Text(body['message']),
          actions: [
            TextButton(
                onPressed: () {
                  Get.off(LoginPage());
                },
                child: Text('Ok'))
          ],
        ),
      );
    } else {
      _showMsg(body['message']);
      // throw "Gagal verify";
    }

    setState(() {
      _isLoading = false;
    });
  }
}
