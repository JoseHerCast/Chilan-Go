import 'package:app/style/my_colors.dart';
import 'package:app/widgets/icon_progress.dart';
import 'package:app/widgets/level_progress_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  int? puntaje;
  HomePage({Key? key, this.puntaje}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final puntajeInicial = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: MyColors.background,
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*Logros y puntaje*/
          Container(
            //color: Colors.green,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconProgress(
                  value: '0',
                  iconPath: 'assets/icons/trophy.png',
                  type: "back",
                ),
                IconProgress(
                  value: '0',
                  iconPath: 'assets/icons/bag.png',
                  type: "al",
                )
              ],
            ),
          ),
          /*Nombre de usuario*/
          Container(
            margin: EdgeInsets.all(30),
            //color: Colors.grey,
            child: Center(
              child: Text(
                "Gabs Segura",
                style: TextStyle(
                  color: MyColors.mainText,
                  fontSize: 28,
                  fontFamily:
                      GoogleFonts.lato(fontWeight: FontWeight.bold).fontFamily,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          /*Avatar*/
          Container(
            margin: EdgeInsets.all(20),
            height: size.height * 0.3,
            child: Image.asset(
              'assets/images/ajolote.gif',
            ),
          ),
          /*Rango*/
          Container(
            margin: EdgeInsets.only(bottom: 20),
            //color: Colors.grey,
            child: Center(
              child: Text(
                "Nomada",
                style: TextStyle(
                  color: MyColors.mainText,
                  fontSize: 22,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          /*Nivel y progreso*/
          LevelProgressCard(
            size: size,
            lv: 1,
          ),
        ],
      ),
    );
  }
}
