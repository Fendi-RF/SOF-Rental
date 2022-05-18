import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/data/models/vehicle_spec.dart';
import 'package:car_rental_app_ui/pages/profile_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class PaymentFormBottom extends StatefulWidget {
  const PaymentFormBottom({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;
  @override
  State<PaymentFormBottom> createState() => _PaymentFormBottomState();
}

class _PaymentFormBottomState extends State<PaymentFormBottom> {
  File? image;
  DateTime? dtStart = DateTime.now();
  DateTime? dtEnd = DateTime.now().add(Duration(days: 1));
  int? diff;
  bool _isLoading = false;
  String dropDownValue = 'BNI';

  final _formKey = GlobalKey<FormState>();

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
        (this.image = imageTemp);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : ' + e.toString());
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    String? payerName;
    String amount = widget.invoice.rentPrice.toString();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please insert Payer\'s name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Payer\'s Name'),
                  onChanged: (v) {
                    setState(() {
                      payerName = v;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: themeData.secondaryHeaderColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                  items: <String>['BNI', 'BCA', 'BRI', 'Mandiri']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please insert Amount to Pay';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Amount to Pay'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    setState(() {
                      amount = v;
                    });
                  },
                ),
                BuildButton(
                  data: 'Upload Payment Proof',
                  onClicked: () {
                    _pickImage();
                  },
                  icon: UniconsLine.picture,
                  image: image,
                  size: size,
                ),
              ],
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
                    onTap: () {
                      // _rent();
                      if (_formKey.currentState!.validate()) {
                        if (image == null) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                  title: Text(
                                      'Please insert your payment proof')));
                        } else {
                          _pay(themeData, widget.invoice, payerName,
                              dropDownValue, amount);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff3b22a1),
                      ),
                      child: Align(
                        child: Text(
                          'Rent',
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
    );
  }

  // void _rent() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   var streamedRes = await Network().postMultipartRental(
  //       'rental/' + widget.cars.vehicleSlug,
  //       dtStart.toString(),
  //       dtEnd.toString(),
  //       (diff! * int.parse(widget.cars.rentPrice)).toString(),
  //       image!);
  //   var res = await http.Response.fromStream(streamedRes);
  //   var body = jsonDecode(res.body);
  //   if (res.statusCode == 200) {
  //     print('Success');
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               title: Text(body['status']),
  //               content: Text("Transaction Code: \n ${body['invoice_code']}"),
  //               actions: [
  //                 TextButton(
  //                     onPressed: () {
  //                       Get.to(ProfilePage());
  //                     },
  //                     child: Text('Pay Now')),
  //                 TextButton(
  //                     onPressed: () {},
  //                     child: Text(
  //                       'Later',
  //                       style: TextStyle(color: Colors.grey),
  //                     ))
  //               ],
  //             ));
  //   } else {
  //     _showMsg(body['message']);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
  void _pay(ThemeData themeData, Invoice invoice, String? payerName,
      String? dropValue, String amount) async {
    setState(() {
      _isLoading = true;
    });

    var streamedRes = await Network().postMultipartPay(
        'invoice/' + invoice.transactionCode.toString(),
        payerName,
        dropValue,
        amount,
        image!);
    var res = await http.Response.fromStream(streamedRes);
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      // _showMsg(body['message']);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(body['status']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/lottie/car_family.json'),
              Text(
                body['message'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      buildUnderColor(themeData, 'Required Amount'),
                      Text(
                        body['required'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      buildUnderColor(themeData, 'Amount Paid'),
                      Text(
                        body['your_money'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              buildUnderColor(themeData, 'Cashback'),
              Text(
                body['cashback'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                  'You can pick up your rented car at the closest SOF Rent Area'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.off(ProfilePage());
                },
                child: Text('Ok')),
          ],
        ),
      );
    } else {
      // _showMsg(body['message']);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: body['status'],
                content: body['message'],
              ));
      // throw "wtf";
    }

    setState(() {
      _isLoading = false;
    });
  }

  Container buildUnderColor(ThemeData themeData, String text) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: themeData.secondaryHeaderColor))),
      child: Text(
        text,
        style: TextStyle(color: themeData.primaryColor),
      ),
    );
  }
}

class TransactionFormFromBrands extends StatefulWidget {
  const TransactionFormFromBrands({Key? key, required this.cars})
      : super(key: key);

  final VehicleSpec cars;
  @override
  State<TransactionFormFromBrands> createState() =>
      _TransactionFormFromBrandsState();
}

class _TransactionFormFromBrandsState extends State<TransactionFormFromBrands> {
  File? image;
  DateTime? dtStart;
  DateTime? dtEnd;
  int? diff;
  bool _isLoading = false;

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
        (this.image = imageTemp);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : ' + e.toString());
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Start Rent Date',
          ),
          DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            onChanged: (val) => print(val),
            validator: (val) {
              // print(val);
              return null;
            },
            onSaved: (val) => dtStart = DateTime.tryParse(val!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'End Rent Date',
            ),
          ),
          DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            onChanged: (val) => dtStart,
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) {
              dtEnd = DateTime.tryParse(val!);
              diff = daysBetween(dtStart!, dtEnd!);
            },
          ),
          BuildButton(
            data: 'Upload ID Card',
            onClicked: () {
              _pickImage();
            },
            icon: UniconsLine.picture,
            image: image,
            size: size,
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
                    onTap: () {
                      // _rent();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff3b22a1),
                      ),
                      child: Align(
                        child: Text(
                          'Rent',
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
    );
  }
}
