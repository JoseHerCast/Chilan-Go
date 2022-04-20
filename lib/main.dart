import 'package:app/screens/forgot_password_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/navigator_screen.dart';
import 'package:app/screens/qr_scanner_screen.dart';
import 'package:app/screens/scratcher_gift.dart';
import 'package:app/screens/welcome_screen.dart';
import 'package:app/style/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Main function.
void main() {
  runApp(const MyApp());
}

/// Example app widget.
class MyApp extends StatelessWidget {
  /// Main app widget.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Login',
      theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          primaryColor: MyColors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginScreen(),
        '/forgotPass': (BuildContext context) => const ForgotPasswordScreen(),
        '/welcome': (BuildContext context) => const WelcomeScreen(),
        '/home': (BuildContext context) => HomePage(),
        '/qrScanner': (BuildContext context) => const QrScanner(),
        '/navigatorScreen': (BuildContext context) => const NavigatorScreen(),
        '/scratcherScreen': (BuildContext context) => const ScratcherGift(),
      },
    );
  }
}
