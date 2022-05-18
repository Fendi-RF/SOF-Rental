import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/API/requests.dart';
import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/pages/history_page.dart';
import 'package:car_rental_app_ui/pages/login_page.dart';
import 'package:car_rental_app_ui/pages/payment_form.dart';
import 'package:car_rental_app_ui/widgets/about_us.dart';
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
  List<Invoice>? history;

  @override
  void initState() {
    super.initState();
    checkPay();
    checkJson();
    setState(() {
      user = _loadUserData();
      _invoice = Request().getInvoice();
      _history = Request().getHistory();
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
    // print(invoice?.map((e) => e).toList());
    history = await Request().getHistory();
  }

  void checkJson() async {}

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      drawer: AboutUsDrawer(themeData: themeData),
      extendBodyBehindAppBar: true,
      backgroundColor: themeData.backgroundColor,
      bottomNavigationBar: buildBottomNavBar(2, size, themeData),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          iconTheme: IconThemeData(color: themeData.secondaryHeaderColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
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
            TextButton(
              onPressed: () {
                _showDialog();
              },
              child: Text('Log Out', style: TextStyle(color: Colors.red)),
            ),
            // Profile(name: user.name),

            buildCategory('Unpaid Rent', size, themeData, () {}),
            FutureBuilder(
                future: _invoice,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Invoice> inv = snapshot.data;

                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: inv.map((e) => buildInvoiceTile(e)).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            buildCategory('Recent History', size, themeData, () {}),
            FutureBuilder(
                future: _history,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Invoice> inv = snapshot.data;

                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: inv.map((e) => buildHistoryTile(e)).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
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
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : TextButton(
                        onPressed: () {
                          _logout();
                        },
                        child:
                            Text('Yes', style: TextStyle(color: Colors.red))),
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
    setState(() {
      _isLoading = true;
    });

    var response = await Network().logout('logout');
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _showMsg(body['message']);
      Get.off(LoginPage());
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = true;
    });
  }

  InkWell buildInvoiceTile(Invoice inv) {
    return InkWell(
      onTap: () {
        Get.to(PaymentForm(
          inv: inv,
        ));
      },
      child: ListTile(
        title: Text(
          '${inv.vehicleSpec?.vehicleName}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('${inv.transactionCode}'),
        trailing: Text(
          'Rp${inv.rentPrice}',
          style: TextStyle(color: Colors.amber, fontSize: 18),
        ),
      ),
    );
  }

  InkWell buildHistoryTile(Invoice inv) {
    return InkWell(
      onTap: () {
        Get.to(HistoryPage(
          inv: inv,
        ));
      },
      child: ListTile(
        title: Text(
          '${inv.vehicleSpec?.vehicleName}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('${inv.transactionCode}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rp${inv.rentPrice}',
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
            Text('Paid at : ${inv.payment?.paidDate}')
          ],
        ),
      ),
    );
  }
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
