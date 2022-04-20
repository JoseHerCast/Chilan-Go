import 'package:app/screens/navigator_screen.dart';
import 'package:app/style/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class ScratcherGift extends StatefulWidget {
  const ScratcherGift({Key? key}) : super(key: key);

  @override
  State<ScratcherGift> createState() => _ScratcherGiftState();
}

class _ScratcherGiftState extends State<ScratcherGift> {
  @override
  Widget build(BuildContext context) {
    var _opacity = 0.0;
    bool buttonShow = false;
    int _puntajeInicial = 725;
    return Column(
      children: [
        SizedBox(
          height: 150,
        ),
        AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "¡Descubre quien te acompañará en tu aventura!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          content: Scratcher(
            accuracy: ScratchAccuracy.low,
            brushSize: 50,
            threshold: 25,
            color: Colors.grey,
            onChange: (value) {
              print("Scratch progress: $value%");
              if (value > 75) {
                buttonShow = true;
              }
            },
            onThreshold: () {
              setState(() {
                _opacity = 1;
              });
            },
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: MyColors.ligthBlue,
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/ajolote.gif',
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => NavigatorScreen(
                        puntaje: _puntajeInicial,
                      )),
            );
          },
          child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyColors.mainBlue,
              ),
              child: SizedBox(
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Continuar",
                      style: TextStyle(color: MyColors.white),
                    ),
                  ))),
        ),
      ],
    );
  }
}
