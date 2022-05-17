import 'dart:convert';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/widgets/registerPage/registVerif.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading = false;
  final TextEditingController controller = TextEditingController();
  String otp = '';
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeData.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.secondaryHeaderColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Reset Password',
              style: GoogleFonts.bebasNeue(
                  fontSize: 35, color: themeData.primaryColor),
            ),
            Text('Enter your email to receive a token for reseting password'),
            SizedBox(
              height: size.height * 0.03,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please insert the email';
                  } else if (!EmailValidator.validate(v)) {
                    return 'Email is not appropriate';
                  }
                  return null;
                },
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: 'email@example.com'),
                keyboardType: TextInputType.emailAddress,
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
                              _reset();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3b22a1),
                            ),
                            child: Align(
                              child: Text(
                                'Submit',
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
          ],
        ),
      ),
    );
  }

  void _reset() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': controller.text};

    var res = await Network().auth(data, 'reset');
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(body['status']),
          content: Text(body['message']),
          actions: [
            TextButton(
                onPressed: () {
                  Get.to(RegisterVerif(
                    email: controller.text,
                  ));
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
