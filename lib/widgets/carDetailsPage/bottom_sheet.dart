import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  File? image;
  DateTime? dtStart;
  DateTime? dtEnd;
  int? diff;

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
              print(val);
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
          buildButton(
            data: 'Upload ID Card',
            onClicked: () {
              _pickImage();
            },
            icon: UniconsLine.picture,
            image: image,
            size: size,
          ),
          Spacer(),
          SizedBox(
            height: size.height * 0.07,
            width: size.width,
            child: InkWell(
              onTap: () {},
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

class buildButton extends StatelessWidget {
  const buildButton({
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
          image != null
              ? Container(
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(image!), fit: BoxFit.cover),
                  ),
                )
              : Container(height: size.height * 0.1),
          Container(
            color: Colors.black.withOpacity(0.27),
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
