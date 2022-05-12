import 'dart:convert';

import 'package:car_rental_app_ui/data/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterVerif extends StatefulWidget {
  const RegisterVerif({Key? key}) : super(key: key);

  @override
  State<RegisterVerif> createState() => _RegisterVerifState();
}

class _RegisterVerifState extends State<RegisterVerif> {
  bool _isLoading = false;
  final TextEditingController controller = TextEditingController();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
              'We already sent you verification token. PLease check your email inbox '),
          TextField(
            controller: controller,
          ),
          TextButton(
            onPressed: () {
              _verifyAcc();
            },
            child: Text('Verify'),
          )
        ],
      ),
    );
  }

  void _verifyAcc() async {
    setState(() {
      _isLoading = true;
    });

    var res = await Network().authUrl(controller.text, 'register');
    var body = json.decode(res.body);
    if (res.statusCode == 201) {
      Network().getToken();
      Get.to(RegisterVerif());
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
