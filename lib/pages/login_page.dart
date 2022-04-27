import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:car_rental_app_ui/widgets/loginPage/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

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

  bool pwVisible = false;

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
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: size.height / 4, right: 20),
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
                              child: Text('Welcome'.toUpperCase(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white.withOpacity(0.65))),
                            ),
                            Text('Long time no see.',
                                style: GoogleFonts.rubik(
                                    fontSize: 65,
                                    color: Colors.white.withOpacity(0.80))),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input Username/Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    prefixIcon: Icon(UniconsLine.envelope),
                                    fillColor: Colors.white.withOpacity(0.35),
                                    filled: true,
                                    hintText: 'Email or Username',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.75))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input Password';
                                  }
                                  return null;
                                },
                                obscureText: pwVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    suffixIcon: IconButton(
                                      tooltip: pwVisible
                                          ? 'Show Password'
                                          : 'Hide Password',
                                      onPressed: () {
                                        setState(() {
                                          pwVisible = !pwVisible;
                                        });
                                      },
                                      icon: Icon(pwVisible
                                          ? UniconsLine.eye
                                          : UniconsLine.eye_slash),
                                    ),
                                    prefixIcon: Icon(UniconsLine.lock),
                                    fillColor: Colors.white.withOpacity(0.35),
                                    filled: true,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.75))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Forgot password?',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue.withOpacity(0.75))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(HomePage(),
                                        transition: Transition.downToUp);
                                  }
                                },
                                child: Text('Login'.toUpperCase(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Don\'t have account? ',
                                    children: [
                                      TextSpan(
                                        text: 'Create new account',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
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
                                      )
                                    ]),
                              ),
                            ),
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
}
