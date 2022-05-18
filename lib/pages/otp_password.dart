import 'dart:convert';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/pages/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPassVerif extends StatefulWidget {
  const ResetPassVerif({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPassVerif> createState() => _ResetPassVerifState();

  final String email;
}

class _ResetPassVerifState extends State<ResetPassVerif> {
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
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: themeData.secondaryHeaderColor,
          ),
        ),
        backgroundColor: themeData.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.bebasNeue(
                  fontSize: 35, color: themeData.primaryColor),
            ),
            Text(
              'We already sent otp code to your email',
              style: TextStyle(color: themeData.primaryColor),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  PinCodeTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP Code';
                      } else if (value.length < 6) {
                        return 'Please enter a valid OTP Code';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: controller,
                    pinTheme: PinTheme(activeColor: Colors.green),
                    textInputAction: TextInputAction.go,
                    appContext: context,
                    length: 6,
                    onChanged: (onChanged) {
                      setState(() {
                        otp = onChanged;
                      });
                      // print(otp);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              _verifyAcc;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3b22a1),
                            ),
                            child: Align(
                              child: Text(
                                'Verify',
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

  void _verifyAcc() async {
    setState(() {
      _isLoading = true;
    });

    var data = {};

    var res = await Network().auth(data, 'reset/$otp');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      Get.off(NewPasswordForm(
        otp: otp,
      ));
    } else {
      _showMsg(body['message']);
      // throw "Gagal verify";
    }

    setState(() {
      _isLoading = false;
    });
  }
}
