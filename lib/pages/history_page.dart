import 'package:car_rental_app_ui/data/models/invoice.dart';
import 'package:car_rental_app_ui/widgets/paymentForm/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

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

class HistoryFromAlter extends StatefulWidget {
  const HistoryFromAlter({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;

  @override
  State<HistoryFromAlter> createState() => _HistoryFromAlterState();
}

class _HistoryFromAlterState extends State<HistoryFromAlter> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeData.backgroundColor,
          iconTheme: IconThemeData(color: themeData.primaryColor),
          bottom: TabBar(
            indicatorColor: themeData.secondaryHeaderColor,
            tabs: [
              Tab(
                  icon: Icon(
                UniconsLine.bill,
                color: themeData.primaryColor,
              )),
              Tab(
                  icon: Icon(
                UniconsLine.transaction,
                color: themeData.primaryColor,
              ))
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            color: themeData.backgroundColor,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16),
                height: size.height * 0.75,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(color: themeData.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
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
                    HistoryRow('Number plater',
                        widget.invoice.vehicleSpec!.numberPlate),
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
                            .format(widget.invoice.endRentDate as DateTime))
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: themeData.backgroundColor,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16),
                height: size.height * 0.75,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(color: themeData.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: themeData.cardColor,
                        ),
                        height: size.height * 0.05,
                        child: Center(
                          child: Text(
                            'Payment',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow('Payment type',
                        widget.invoice.payment!.paymentType.toString()),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow(
                        'Paid date',
                        DateFormat('yyyy-MM-dd').format(
                            widget.invoice.payment!.paidDate as DateTime)),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow('Payer\'s name',
                        widget.invoice.payment!.payerName.toString()),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow(
                        'Bank name', widget.invoice.payment!.bank.toString()),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow(
                        'Ref number', widget.invoice.payment!.noRef.toString()),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    HistoryRow('Paid amount',
                        'Rp${widget.invoice.payment!.paidTotal.toString()}')
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Row HistoryRow(String text, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
      ),
      Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ],
  );
}
