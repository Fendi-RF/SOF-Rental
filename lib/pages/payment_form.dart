import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/widgets/paymentForm/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key? key, required this.inv}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();

  final Invoice inv;
}

class _PaymentFormState extends State<PaymentForm> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: themeData.backgroundColor,
      ),
      body: Container(
        color: themeData.backgroundColor,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            height: size.height * 0.8,
            width: size.width * 0.95,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Transaction Code'),
                        Text(
                          widget.inv.transactionCode,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Amount'),
                        Text(
                          'Rp${widget.inv.rentPrice}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Car Name'),
                        Text(
                          widget.inv.vehicleSpec.vehicleName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Number Plate'),
                        Text(
                          widget.inv.vehicleSpec.numberPlate,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Start Rent Date'),
                        Text(
                          widget.inv.startRentDate.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'End Rent Date'),
                        Text(
                          widget.inv.endRentDate.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Align(
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
                          showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  PaymentFormBottom(invoice: widget.inv));
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
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: themeData.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
      ),
    );
  }
}

Container buildUnderColor(ThemeData themeData, String text) {
  return Container(
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: themeData.secondaryHeaderColor))),
    child: Text(
      text,
      style: TextStyle(color: themeData.primaryColor),
    ),
  );
}
