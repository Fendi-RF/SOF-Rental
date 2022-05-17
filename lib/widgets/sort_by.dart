import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SortBy extends StatelessWidget {
  const SortBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildList(UniconsLine.sort_amount_down,
            'Sort By Alphabetical Ascending', () {}),
        buildList(UniconsLine.sort_amount_up, 'Sort By Alphabetical Descending',
            () {}),
        buildList(
            UniconsLine.sort_amount_down, 'Sort By Date Ascending', () {}),
        buildList(UniconsLine.sort_amount_up, 'Sort By Date Descending', () {}),
      ]),
    );
  }
}

ListTile buildList(IconData icon, String text, VoidCallback onTaps) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      onTaps();
    },
  );
}
