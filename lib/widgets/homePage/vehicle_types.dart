// import 'dart:convert';

// import 'package:car_rental_app_ui/data/api_url.dart';
// import 'package:car_rental_app_ui/widgets/homePage/category.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:http/http.dart' as http;

// Column buildTopBrandsWithJson(Size size, ThemeData themeData) {
//   return Column(
//     children: [
//       buildCategory('Vehicle Types', size, themeData, () {
//         Get.to(Types());
//       }),
//       TopBrandJson(
//         size: size,
//         themeData: themeData,
//       ),
//     ],
//   );
// }

// class VehicleTypeJson extends StatelessWidget {
//   const VehicleTypeJson({
//     Key? key,
//     required this.size,
//     required this.themeData,
//   }) : super(key: key);

//   final Size size;
//   final ThemeData themeData;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: size.height * 0.015),
//       child: FutureBuilder(
//         future: getBrands(1),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.hasData) {
//             List<Brand> brands = snapshot.data;
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: brands
//                   .map((Brand brand) => buildBrandLogofromJson(
//                       Image.network(
//                         baseAssetUrl + brand.brandImage,
//                         height: size.height * 0.1,
//                       ),
//                       size,
//                       themeData,
//                       brand))
//                   .toList(),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// Future<List<Type>> getBrands(int ind) async {
//   final response = await http.get(Uri.parse(baseUrl + 'type/'),
//       headers: {"Accept": "application/json", "Authorization": apiBearerToken});

//   if (response.statusCode == 200) {
//     List<dynamic> body = jsonDecode(response.body);
//     List<Type> brands = body.map((dynamic item) => Type.fromJson(item)).toList()
//       ..sort(((a, b) => a.typeName.compareTo(b.typeName)));

//     var brandsDesc = brands.reversed.toList();

//     switch (ind) {
//       case 1:
//         return brands;
//         break;
//       default:
//         return brandsDesc;
//     }
//   } else {
//     throw "Can not connect to the API";
//   }
// }
