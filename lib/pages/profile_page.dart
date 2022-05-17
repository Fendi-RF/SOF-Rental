import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/pages/payment_form.dart';
import 'package:car_rental_app_ui/widgets/bottom_nav_bar.dart';
import 'package:car_rental_app_ui/widgets/carDetailsPage/bottom_sheet.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

import '../data/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late User user;
  var user;
  Future? _invoice;
  Future? _history;
  bool _isNull = true;
  bool _customTileExp = false;
  bool _isLoading = false;

  String dropValue = 'BNI';
  File? _image;
  String? payerName;
  String? amount;

  List<Invoice>? invoice;

  @override
  void initState() {
    super.initState();
    checkJson();
    setState(() {
      user = _loadUserData();
      _invoice = Request().getInvoice();
      _history = Request().getHistory();
      checkPay();
    });

    // _loadUserData();
  }

  Future<User> _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var map = jsonDecode(localStorage.getString('user') ?? '');
    return User.fromJson(map);
    // print(user);
    // setState(() {
    //   user = User.fromJson(map);
    // });

    setState(() {
      this.user = user;
    });
  }

  void checkPay() async {
    invoice = await Request().getInvoice();
    print(invoice?.map((e) => e).toList());
  }

  void checkJson() async {}

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      setState(() {
        (_image = imageTemp);
        print(image.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      bottomNavigationBar: buildBottomNavBar(2, size, themeData),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                color: themeData.cardColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              // child: Profile(avatar: avatar, name: name),
              child: FutureBuilder(
                  future: user,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      User thisUser = snapshot.data;
                      return Profile(
                        avatar: thisUser.avatar,
                        name: thisUser.name,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            // Profile(name: user.name),

            buildCategory('Activity Status', size, themeData, () {}),

            FutureBuilder(
                future: _invoice,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Invoice> inv = snapshot.data;

                    return ListView(
                      shrinkWrap: true,
                      children: inv.map((e) => buildInvoiceTile(e)).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            buildCategory('Recent History', size, themeData, () {}),
            Container(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: Text('There is no history'),
              ),
            ),
            FutureBuilder(
                future: _history,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Invoice> inv = snapshot.data;

                    return ListView(
                      shrinkWrap: true,
                      children: inv.map((e) => buildHistory(e)).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            TextButton(
              onPressed: () {
                _showDialog();
              },
              child: Text('Log Out', style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Log Out',
              ),
              content: Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                    onPressed: () {
                      _logout();
                    },
                    child: Text('Yes', style: TextStyle(color: Colors.red))),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('No'),
                )
              ],
            ));
  }

  void _logout() async {
    var response = await Network().logout('logout');
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _showMsg(body['message']);
      Get.off(LoginPage());
    } else {
      _showMsg(body['message']);
    }
  }

  InkWell buildInvoiceTile(Invoice inv) {
    return InkWell(
      onTap: () {
        Get.to(PaymentForm(
          inv: inv,
        ));
      },
      child: ListTile(
        leading: Icon(UniconsLine.wallet),
        title: Text(
            '${inv.transactionCode}      |     ${inv.vehicleSpec.vehicleName}'),
      ),
    );
  }

  ExpansionTile buildInvoice(Invoice inv, Size size, ThemeData themeData) {
    return ExpansionTile(
      leading: Icon(UniconsLine.wallet),
      title: Text(
          inv.transactionCode + '     |      ' + inv.vehicleSpec.vehicleName),
      trailing: Icon(Icons.arrow_drop_down),
      children: [
        Container(
          padding: EdgeInsets.all(8),
          height: size.height * 0.5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Start Rent Date'),
                      Text(inv.startRentDate.toString())
                    ],
                  ),
                  Column(
                    children: [
                      Text('End Rent Date'),
                      Text(inv.endRentDate.toString())
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(inv.status),
              Form(
                child: Container(
                  color: themeData.cardColor,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Payer\'s Name'),
                        onChanged: (v) {
                          setState(() {
                            payerName = v;
                          });
                        },
                      ),
                      DropdownButton(
                          value: dropValue,
                          items: <String>['BCA', 'BRI', 'BNI', 'Mandiri']
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (String? v) {
                            setState(() {
                              dropValue = v!;
                            });
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                        ),
                        onChanged: (v) {
                          setState(() {
                            amount = v;
                          });
                        },
                      ),
                      BuildButton(
                          data: 'Upload Payment Proof',
                          onClicked: _pickImage,
                          icon: UniconsLine.image,
                          image: _image,
                          size: size)
                    ],
                  ),
                ),
              ),
              Spacer(),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: size.height * 0.07,
                      width: size.width,
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          var streamedResp = await Network().postMultipartPay(
                              'invoice/${inv.transactionCode}',
                              payerName!,
                              dropValue,
                              amount!,
                              _image!);

                          var res =
                              await http.Response.fromStream(streamedResp);
                          var body = jsonDecode(res.body);

                          if (res.statusCode == 200) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(body['status']),
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  "Required amount : ${body['required']}"),
                                              Text(
                                                  "Paid amount : ${body['your_money']}")
                                            ],
                                          ),
                                          Text(
                                              "Cashback : ${body['cashback']}"),
                                          Text(
                                              'You can pick up your rental car at the closest SOF Rent Area'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {}, child: Text('Ok'))
                                      ],
                                    ));
                          } else {
                            // _showMsg(body['message']);
                            throw "wtf";
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff3b22a1),
                          ),
                          child: Align(
                            child: Text(
                              'Pay',
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
                    )
            ],
          ),
        )
      ],
    );
  }

  ExpansionTile buildHistory(Invoice inv) {
    return ExpansionTile(
      leading: Icon(UniconsLine.wallet),
      title: Text(
          inv.transactionCode + '      |      ' + inv.vehicleSpec.vehicleName),
      trailing: Icon(Icons.arrow_drop_down),
    );
  }

  void _pay() async {}
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.name,
    required this.avatar,
  }) : super(key: key);

  final String name;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(baseAssetUrl + avatar),
            child: Text('SOF'),
            radius: 35,
          ),
        ),
        Text(name)
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    Key? key,
    required this.data,
    required this.onClicked,
    required this.icon,
    this.image,
    required this.size,
  }) : super(key: key);

  final String data;
  final VoidCallback onClicked;
  final IconData icon;
  final File? image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onClicked();
      },
      child: Stack(
        children: [
          image == null
              ? Container(height: size.height * 0.1)
              : Container(
                  height: size.height * 0.1,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(image!), fit: BoxFit.cover),
                  ),
                ),
          Container(
            color: Colors.black.withOpacity(0.27),
            height: size.height * 0.1,
          ),
          Positioned.fill(
            child: Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: 16,
                ),
                Text(data)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
