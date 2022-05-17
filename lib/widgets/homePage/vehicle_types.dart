import 'package:car_rental_app_ui/data/models/brands.dart';
import 'package:car_rental_app_ui/data/models/types.dart';
import 'package:car_rental_app_ui/widgets/homePage/category.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class VehicleTypes extends StatelessWidget {
  const VehicleTypes({
    Key? key,
    required this.size,
    required this.themeData,
    required this.types,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final Future types;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: types,
        builder: (BuildContext buildContext, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Types> type = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: type
                  .map((Types e) => buildTypesFromJson(size, themeData, e))
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Padding buildTypesFromJson(Size size, ThemeData themeData, Types type) {
  IconData icon;
  switch (type.typeName) {
    case 'Motorcycle':
      icon = UniconsLine.car_slash;
      break;
    case 'Car':
      icon = UniconsLine.car;
      break;
    case 'Bicyle':
      icon = UniconsLine.car_slash;
      break;
    default:
      icon = UniconsLine.lock;
  }
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03, vertical: size.width * 0.05),
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: size.width * 0.18,
        width: size.width * 0.18,
        child: Container(
          child: Icon(icon),
          decoration: BoxDecoration(
            color: themeData.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Column buildTypes(Size size, ThemeData themeData, Future types) {
  return Column(children: [
    buildCategory('Vehicle Types', size, themeData, () {}),
    VehicleTypes(size: size, themeData: themeData, types: types),
  ]);
}
