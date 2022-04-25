import 'package:car_rental_app_ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CarsDetails extends StatefulWidget {
  const CarsDetails({Key? key}) : super(key: key);

  @override
  State<CarsDetails> createState() => _CarsDetailsState();
}

class _CarsDetailsState extends State<CarsDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarViewAll(
          size: size,
          themeData: Theme.of(context),
        ),
      ),
      body: CarsList(size: size),
    );
  }
}

class CarsList extends StatelessWidget {
  const CarsList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            // return ListTile(
            //   title: Text("List item $index"),
            //   trailing: Image.asset('assets/images/golf.png'),
            // );
            return Container(
              height: size.height * 0.1,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Toyota Alpha X-$index',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff3b22a1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 15),
                            color: Colors.black.withOpacity(0.23),
                            blurRadius: 18,
                          )
                        ]),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/golf.png',
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
