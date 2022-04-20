import 'package:app/screens/navigator_screen.dart';
import 'package:app/screens/scratcher_gift.dart';
import 'package:app/style/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: MyColors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ScratcherGift()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: MyColors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: MyColors.white,
      // globalHeader: const Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //         padding: EdgeInsets.only(top: 16, right: 16),
      //         child: Icon(Icons.arrow_back_ios_rounded)),
      //   ),
      // ),
      globalFooter: Container(
        color: MyColors.mainBlue,
        width: double.infinity,
        height: 60,
        child: TextButton(
          child: const Text(
            '¡Vamos ahora mismo!',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "¡Bienvenido!",
          body:
              "Te damos la bienvenida a Chilan-Go tu aplicacion para explorar la CDMX",
          image: _buildImage('images/welcome_one.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explora",
          body: "Descubre los lugares que nosotros te recomendamos",
          image: _buildImage('images/welcome_two.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Busca",
          body: "Escanea los códigos Qr que se encuentran en cada lugar",
          image: _buildImage('images/welcome_three.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Sube de nivel",
          body:
              "Cada vez que escanees un código Qr obtendrás puntos para subir de nivel",
          image: _buildImage('images/welcome_four.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Seras recompensado",
          body:
              "Recuerda que cuanto más uses la aplicación, más beneficios obtendrás",
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('images/welcome_five.gif'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(
        Icons.arrow_back_ios_rounded,
        color: MyColors.mainBlue,
      ),
      skip: const Text('Skip',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: MyColors.mainBlue,
          )),
      next: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: MyColors.mainBlue,
      ),
      done: const Text('¡LISTO!',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: MyColors.mainBlue,
          )),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: MyColors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: MyColors.ligthBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
