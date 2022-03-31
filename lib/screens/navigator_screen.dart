import 'package:app/screens/home_screen.dart';
import 'package:app/screens/notifications_screen.dart';
import 'package:app/screens/places_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/qr_scanner_screen.dart';
import 'package:app/style/my_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  //Indice del navItem
  int indexTap = 0;
  //Arreglo de vistas
  final List<Widget> screensArray = [
    const HomePage(),
    const PlacesScreen(),
    const QrScanner(),
    const NotificationsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: indexTap == 0
            ? MyColors.background
            : indexTap == 1
                ? MyColors.white
                : indexTap == 2
                    ? Colors.black
                    : indexTap == 3
                        ? MyColors.white
                        : MyColors.white,
        color: MyColors.mainBlue,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 35,
            color: MyColors.white,
          ),
          Icon(
            Icons.place,
            size: 35,
            color: MyColors.white,
          ),
          Icon(
            Icons.qr_code_scanner,
            size: 35,
            color: MyColors.white,
          ),
          Icon(
            Icons.notifications,
            size: 35,
            color: MyColors.white,
          ),
          Icon(
            Icons.settings,
            size: 35,
            color: MyColors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            indexTap = index;
          });
        },
      ),
      body: screensArray[indexTap],
    );
  }
}
