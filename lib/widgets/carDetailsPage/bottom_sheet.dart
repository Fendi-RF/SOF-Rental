import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:car_rental_app_ui/data/API/api_url.dart';
import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/cars%20copy.dart';
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

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key, required this.cars}) : super(key: key);

  final Cars cars;
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  File? image;
  DateTime? dtStart = DateTime.now();
  DateTime? dtEnd = DateTime.now().add(Duration(days: 1));
  int? diff;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      diff = daysBetween(dtStart ?? DateTime.now(),
          dtEnd ?? DateTime.now().add(Duration(days: 1)));
    });
  }

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
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
                    onChanged: (val) => setState(() {
                          dtStart = DateTime.tryParse(val);
                          diff = daysBetween(dtStart!, dtEnd!);
                        }),
                    validator: (val) {
                      // print(val);
                      return null;
                    },
                    onSaved: (val) => setState(() {
                          dtStart = DateTime.tryParse(val!);
                          diff = daysBetween(dtStart!, dtEnd!);
                        })),
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
                  onChanged: (val) => setState(() {
                    dtEnd = DateTime.tryParse(val);
                    diff = daysBetween(dtStart!, dtEnd!);
                  }),
                  validator: (val) {
                    // print(val);
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      dtEnd = DateTime.tryParse(val!);
                      diff = daysBetween(dtStart!, dtEnd!);
                    });
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
                      if (_formKey.currentState!.validate()) {
                        if (image == null) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        'Please insert your ID for guarantee purpose'),
                                  ));
                        } else {
                          _rent();
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

  void _rent() async {
    setState(() {
      _isLoading = true;
    });

    var streamedRes = await Network().postMultipartRental(
        'rental/' + widget.cars.vehicleSlug,
        dtStart.toString(),
        dtEnd.toString(),
        (diff! * int.parse(widget.cars.rentPrice)).toString(),
        image!);
    var res = await http.Response.fromStream(streamedRes);
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(body['message']),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/lottie/checkmark.json'),
                    Text("Transaction Code: \n ${body['invoice_code']}"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.to(ProfilePage());
                      },
                      child: Text('Pay Now')),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Later',
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              ));
    } else {
      // _showMsg(body['message']);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(body['status']),
                content: Column(
                  children: [
                    Lottie.asset('assets/lottie/cross.json'),
                    Text(body['message']),
                  ],
                ),
              ));
    }

    setState(() {
      _isLoading = false;
    });
  }
}

class TransactionFormBrands extends StatefulWidget {
  const TransactionFormBrands({Key? key, required this.cars}) : super(key: key);

  final VehicleSpec cars;
  @override
  State<TransactionFormBrands> createState() => _TransactionFormBrandsState();
}

class _TransactionFormBrandsState extends State<TransactionFormBrands> {
  File? image;
  DateTime? dtStart = DateTime.now();
  DateTime? dtEnd = DateTime.now().add(Duration(days: 1));
  int? diff;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      diff = daysBetween(dtStart ?? DateTime.now(),
          dtEnd ?? DateTime.now().add(Duration(days: 1)));
    });
  }

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
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
                    onChanged: (val) => setState(() {
                          dtStart = DateTime.tryParse(val);
                          diff = daysBetween(dtStart!, dtEnd!);
                        }),
                    validator: (val) {
                      // print(val);
                      return null;
                    },
                    onSaved: (val) => setState(() {
                          dtStart = DateTime.tryParse(val!);
                          diff = daysBetween(dtStart!, dtEnd!);
                        })),
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
                  onChanged: (val) => setState(() {
                    dtEnd = DateTime.tryParse(val);
                    diff = daysBetween(dtStart!, dtEnd!);
                  }),
                  validator: (val) {
                    // print(val);
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      dtEnd = DateTime.tryParse(val!);
                      diff = daysBetween(dtStart!, dtEnd!);
                    });
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
                      if (_formKey.currentState!.validate()) {
                        if (image == null) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        'Please insert your ID for guarantee purpose'),
                                  ));
                        } else {
                          _rent();
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

  void _rent() async {
    setState(() {
      _isLoading = true;
    });

    var streamedRes = await Network().postMultipartRental(
        'rental/' + widget.cars.vehicleSlug,
        dtStart.toString(),
        dtEnd.toString(),
        (diff! * int.parse(widget.cars.rentPrice)).toString(),
        image!);
    var res = await http.Response.fromStream(streamedRes);
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(body['message']),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/lottie/checkmark.json'),
                    Text("Transaction Code: \n ${body['invoice_code']}"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.to(ProfilePage());
                      },
                      child: Text('Pay Now')),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Later',
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              ));
    } else {
      // _showMsg(body['message']);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(body['status']),
                content: Column(
                  children: [
                    Lottie.asset('assets/lottie/cross.json'),
                    Text(body['message']),
                  ],
                ),
              ));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
