import 'package:app/style/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelProgressCard extends StatelessWidget {
  int lv;
  LevelProgressCard({
    Key? key,
    required this.size,
    required this.lv,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(60),
      ),
      width: size.width * 0.8,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            //color: Colors.orange,
            child: Text(
              "Nivel $lv",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  color: MyColors.mainBlue,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            //color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        color: MyColors.ligthBlue,
                        width: 30,
                        height: 12,
                      ),
                      Container(
                        color: MyColors.mainBlue,
                        width: 270,
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
