import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/widgets/paymentForm/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.inv}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();

  final Invoice inv;
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.primaryColor,
          ),
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
                          widget.inv.transactionCode!,
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
                          widget.inv.vehicleSpec!.vehicleName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Number Plate'),
                        Text(
                          widget.inv.vehicleSpec!.numberPlate,
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
                Container(
                  height: size.height * 0.07,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: themeData.secondaryHeaderColor))),
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Payment type'),
                        Text(
                          widget.inv.payment!.paymentType.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Paid Date'),
                        Text(
                          widget.inv.payment!.paidDate.toString(),
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
                        buildUnderColor(themeData, 'Payer\'s Name'),
                        Text(
                          widget.inv.payment!.payerName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Bank Name'),
                        Text(
                          widget.inv.payment!.bank.toString(),
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
                        buildUnderColor(themeData, 'Ref Number'),
                        Text(
                          widget.inv.payment!.noRef.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        buildUnderColor(themeData, 'Paid Amount'),
                        Text(
                          widget.inv.payment!.paidTotal.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.05),
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
