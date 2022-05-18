import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/pages/history_page.dart';
import 'package:car_rental_app_ui/widgets/paymentForm/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key? key, required this.invoice}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();

  final Invoice invoice;
}

class _PaymentFormState extends State<PaymentForm> {
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
            padding: EdgeInsets.all(16),
            height: size.height * 0.8,
            width: size.width * 0.95,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: themeData.cardColor,
                    ),
                    width: size.width,
                    height: size.height * 0.05,
                    child: Center(
                      child: Text(
                        'Transaction',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow('Transaction code',
                    widget.invoice.transactionCode.toString()),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow(
                    'Amount', 'Rp${widget.invoice.rentPrice.toString()}'),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow('Car name',
                    widget.invoice.vehicleSpec!.vehicleName.toString()),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow(
                    'Number plater', widget.invoice.vehicleSpec!.numberPlate),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow(
                    'Start rent date',
                    DateFormat('yyyy-MM-dd')
                        .format(widget.invoice.startRentDate as DateTime)),
                SizedBox(
                  height: size.height * 0.05,
                ),
                HistoryRow(
                    'End rent date',
                    DateFormat('yyyy-MM-dd')
                        .format(widget.invoice.endRentDate as DateTime)),
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (context) =>
                                  PaymentFormBottom(invoice: widget.invoice));
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
      textAlign: TextAlign.left,
      style: TextStyle(color: themeData.primaryColor),
    ),
  );
}
