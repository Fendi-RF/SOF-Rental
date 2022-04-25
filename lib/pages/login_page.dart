import 'package:car_rental_app_ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child:
                                Image.asset('assets/icons/SOF_Rent_White.png'),
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(UniconsLine.eye)),
                                  prefixIcon: Icon(UniconsLine.lock),
                                  fillColor: Colors.white.withOpacity(0.35),
                                  filled: true,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.75))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.withOpacity(0.75))),
                              onPressed: () {
                                Get.to(HomePage(),
                                    transition: Transition.downToUp);
                              },
                              child: Text('Login'.toUpperCase(),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white.withOpacity(0.75))),
                            onPressed: () {},
                            child: Text('Create new account'.toUpperCase(),
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
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
