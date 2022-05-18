import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsDrawer extends StatelessWidget {
  const AboutUsDrawer({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeData.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (CircleAvatar(
                    radius: 30,
                    child: Text('SOF'),
                  )),
                ),
                Text('About Us',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('XII RPL 1 2021 / 2022',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ))
              ],
            ),
            decoration: BoxDecoration(
              color: themeData.cardColor,
            ),
          ),
          ListTile(
            title: Text(
              'Dayu Fito Alva Saputra',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text('Copywriter'),
            trailing: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/fito.jpg',
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Dimas Ramadhan Aji Kusuma ',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text('UI/UX Designer'),
            trailing: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/dimas.jpg',
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Fendi Ridho Ferdiansyah',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text('Back-end Developer'),
            trailing: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/fendi.jpg',
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Fikri Rizqi Ramandhani',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              'Debugger/Tester',
            ),
            trailing: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/fikri.jpg',
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            '© 2022-2022 SOF Rental Mobile Team',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
