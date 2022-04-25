import 'package:car_rental_app_ui/pages/cars_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:unicons/unicons.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({
    Key? key,
    required this.themeData,
    required this.size,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        child: SizedBox(
          height: size.width * 0.2,
          width: size.width * 0.2,
          child: Container(
            decoration: BoxDecoration(
              color: themeData.backgroundColor.withOpacity(0.03),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                UniconsLine.bars,
                color: themeData.secondaryHeaderColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Image.asset(
          themeData.brightness == Brightness.dark
              ? 'assets/icons/SOF_Rent_White.png'
              : 'assets/icons/SOF_Rent_Black.png', //logo
          height: size.height * 0.12),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.05,
          ),
          child: SizedBox(
            height: size.width * 0.1,
            width: size.width * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: themeData.backgroundColor.withOpacity(0.03),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                UniconsLine.exit,
                color: themeData.secondaryHeaderColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarDetail extends StatelessWidget {
  const AppBarDetail({
    Key? key,
    required this.themeData,
    required this.size,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        child: SizedBox(
          height: size.width * 0.01,
          width: size.width * 0.1,
          child: InkWell(
            onTap: () {
              Get.back(); //go back to home page
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeData.cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                UniconsLine.multiply,
                color: themeData.secondaryHeaderColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Image.asset(
        themeData.brightness == Brightness.dark
            ? 'assets/icons/SOF_Rent_White.png'
            : 'assets/icons/SOF_Rent_Black.png',
        height: size.height * 0.12,
        width: size.width * 0.35,
      ),
      centerTitle: true,
    );
  }
}

class AppBarViewAll extends StatelessWidget {
  const AppBarViewAll({
    Key? key,
    required this.themeData,
    required this.size,
  }) : super(key: key);

  final ThemeData themeData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        child: SizedBox(
          height: size.width * 0.01,
          width: size.width * 0.1,
          child: InkWell(
            onTap: () {
              Get.back(); //go back to home page
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeData.cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                UniconsLine.multiply,
                color: themeData.secondaryHeaderColor,
                size: size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Image.asset(
        themeData.brightness == Brightness.dark
            ? 'assets/icons/SOF_Rent_White.png'
            : 'assets/icons/SOF_Rent_Black.png',
        height: size.height * 0.12,
        width: size.width * 0.35,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            UniconsLine.search_alt,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
        IconButton(
          icon: Icon(
            UniconsLine.sort,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Apple', 'Pineapple', 'Watermelon', 'Peach'];

  @override
  List<Widget> buildActions(BuildContext buildContext) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(UniconsLine.multiply),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext buildContext) {
    return IconButton(
        onPressed: () {
          close(buildContext, null);
        },
        icon: Icon(UniconsLine.backward));
  }

  @override
  Widget buildResults(BuildContext buildContext) {
    Size size = MediaQuery.of(buildContext).size;
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return CarsList(size: size);
  }

  @override
  Widget buildSuggestions(BuildContext buildContext) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
      itemCount: matchQuery.length,
    );
  }
}
