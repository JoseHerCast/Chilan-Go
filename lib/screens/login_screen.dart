import 'package:animated_login/animated_login.dart';
import 'package:app/style/my_colors.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widgets/dialog_builders.dart';
import '../widgets/login_functions.dart';

/*Generar clases en donde se tengan definidos todos los textos de la aplicación, de acuerdo a las pantallas, con el fín de poder realizar la traducción español-ingles.

Tomar como ejemplo la clase nativa de la API Animated login, llamada LoginTexts*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LanguageOption language = _languageOptions[1];

  String _disclaimer =
      "Te invitamos a visitar nuestro aviso de privacidad en www.avisodeprivacidad.com";

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedLogin(
          onLogin: (LoginData data) async =>
              _authOperation(LoginFunctions(context).onLogin(data), 'login'),
          onSignup: (SignUpData data) async =>
              _authOperation(LoginFunctions(context).onSignup(data), 'signup'),
          onForgotPassword: _onForgotPassword,
          logo: Image.asset(
            'assets/images/logo_ajolote_2.png',
          ),
          // backgroundImage: 'images/background_image.jpg',
          signUpMode: SignUpModes.both,
          socialLogins: _socialLogins(context),
          loginDesktopTheme: _desktopTheme,
          loginMobileTheme: _mobileTheme,
          loginTexts: _loginTexts,
          changeLanguageCallback: (LanguageOption? _language) {
            if (_language != null) {
              DialogBuilder(context).showResultDialog(language.code == 'ES'
                  ? 'Successfully changed the language to: ${_language.value}.'
                  : 'Lenguaje cambiado con éxito a: ${_language.value}.');
              if (mounted) setState(() => language = _language);
            }
          },
          changeLangDefaultOnPressed: () async => _operation?.cancel(),
          languageOptions: _languageOptions,
          selectedLanguage: language,
          initialMode: currentMode,
          onAuthModeChange: (AuthMode newMode) async {
            currentMode = newMode;
            await _operation?.cancel();
          },
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 740),
            child: TextButton(
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.info,
                    //title: "Aviso de privacidad",
                    desc: _disclaimer,
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                },
                child: Text(
                  disclaimer,
                  style: TextStyle(color: MyColors.white),
                )),
          ),
        ),
      ],
    );
  }

  Future<String?> _authOperation(
      Future<String?> func, String sesionType) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      DialogBuilder(context).showResultDialog(res ?? 'Successful');
      if (sesionType == 'signup') {
        Navigator.pushNamed(context, '/welcome');
      }
      if (sesionType == 'login') {
        Navigator.pushNamed(context, '/navigatorScreen');
      }
    }
    return res;
  }

  Future<String?> _onForgotPassword(String email) async {
    await _operation?.cancel();
    return await LoginFunctions(context).onForgotPassword(email);
  }

  static List<LanguageOption> get _languageOptions => const <LanguageOption>[
        LanguageOption(
          value: 'Español',
          code: 'ES',
          iconPath: 'assets/icons/es.png',
        ),
        LanguageOption(
          value: 'English',
          code: 'EN',
          iconPath: 'assets/icons/en.png',
        ),
      ];

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
        loadingSocialButtonColor: MyColors.mainBlue,
        loadingButtonColor: MyColors.white,
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: MyColors.mainBlue, // const Color(0xFF6666FF),
        formFieldBackgroundColor: MyColors.white,
        formWidthRatio: 60,
        // actionButtonStyle: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all(Colors.blue),
        // ),
        // animatedComponentOrder: const <AnimatedComponent>[
        //   AnimatedComponent(component: LoginComponents.logo),
        //   AnimatedComponent(component: LoginComponents.title),
        //   AnimatedComponent(component: LoginComponents.description),
        //   AnimatedComponent(component: LoginComponents.formTitle),
        //   AnimatedComponent(component: LoginComponents.socialLogins),
        //   AnimatedComponent(component: LoginComponents.useEmail),
        //   AnimatedComponent(component: LoginComponents.form),
        //   AnimatedComponent(component: LoginComponents.notHaveAnAccount),
        //   AnimatedComponent(component: LoginComponents.forgotPassword),
        //   AnimatedComponent(component: LoginComponents.changeActionButton),
        //   AnimatedComponent(component: LoginComponents.actionButton),
        // ],
      );

  LoginTexts get _loginTexts => LoginTexts(
        nameHint: _username,
        emailHint: _emailHint,
        passwordHint: _passwordHint,
        confirmPasswordHint: _confirmPasswordHint,
        login: _login,
        signUp: _signup,
        welcomeBack: _welcomeBack,
        welcomeBackDescription: _welcomeBackDescription,
        welcome: _welcome,
        welcomeDescription: _welcomeDescription,
        signUpFormTitle: _signUpFormTitle,
        signUpUseEmail: _signUpUseEmail,
        loginFormTitle: _loginFormTitle,
        loginUseEmail: _loginUseEmail,
        forgotPassword: _forgotPassword,
        notHaveAnAccount: _notHaveAnAccount,
        alreadyHaveAnAccount: _alreadyHaveAnAccount,
        chooseLanguageTitle: _chooseLanguageTitle,
        passwordMatchingError: _passwordMatchingError,
        dialogButtonText: _dialogButtonText,
      );

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage screen.
  String get _username =>
      language.code == 'ES' ? 'Nombre de usuario' : 'Username';

  String get _login => language.code == 'ES' ? 'Inicio' : 'Login';

  String get _signup => language.code == 'ES' ? 'Registro' : 'Sign Up';

  String get _emailHint => language.code == 'ES' ? 'Correo' : 'Email';

  String get _passwordHint => language.code == 'ES' ? 'Contraseña' : 'Password';

  String get _confirmPasswordHint =>
      language.code == 'ES' ? 'Confirmar contraseña' : 'Confirm password';

  String get _welcomeBack =>
      language.code == 'ES' ? '¡Hola explorador!' : 'Welcome back explorer!';

  String get _welcomeBackDescription => language.code == 'ES'
      ? 'Continuemos con tu camino para convertirte en\n¡el mejor explorador de la CDMX!'
      : 'Let\'s continue on your way to become in the best explorer in CDMX!';
  String get _signUpFormTitle =>
      language.code == 'ES' ? 'titulo registro' : '_signUpFormTitle';

  String get _signUpUseEmail => language.code == 'ES'
      ? 'o usa tu correo para registrarte'
      : 'or use your email account';

  String get _loginFormTitle =>
      language.code == 'ES' ? 'titulo login' : '_signUpFormTitle';

  String get _loginUseEmail => language.code == 'ES'
      ? 'o inicia sesión con tu correo'
      : 'or use your email for registration';

  String get _forgotPassword =>
      language.code == 'ES' ? '¿Olvidaste tu contraseña?' : 'Forgot password?';

  String get _notHaveAnAccount =>
      language.code == 'ES' ? '¿Aún no tienes cuenta?' : 'Not have an account?';

  String get _alreadyHaveAnAccount =>
      language.code == 'ES' ? '¿Ya tienes cuenta?' : 'Already have an account?';

  String get _welcome =>
      language.code == 'ES' ? '¡Bienvenido explorador!' : 'Welcome explorer!';

  String get _welcomeDescription => language.code == 'ES'
      ? '¿Estás listo para iniciar tu aventura por la CDMX?'
      : 'Are you ready for start your adventure in CDMX';

  String get _chooseLanguageTitle =>
      language.code == 'ES' ? 'Elije tu idioma' : 'Choose your language';

  String get _passwordMatchingError => language.code == 'ES'
      ? 'La contraseña es incorrecta, intentalo nuevamente'
      : 'Password error, please try again';

  String get _dialogButtonText =>
      language.code == 'ES' ? '_dialogButtonText' : '_dialogButtonText';

  String get disclaimer =>
      language.code == 'ES' ? 'Aviso de privacidad' : 'Disclaimer';

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
        SocialLogin(
            callback: () async => _socialCallback('Google'),
            iconPath: 'assets/icons/google.png'),
        SocialLogin(
            callback: () async => _socialCallback('Facebook'),
            iconPath: 'assets/icons/facebook.png'),
      ];

  Future<String?> _socialCallback(String type) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(
        LoginFunctions(context).socialLogin(type));
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true && res == null) {
      DialogBuilder(context).showResultDialog(language.code == 'ES'
          ? 'Inicio de sesión exitoso con $type.'
          : 'Successfully logged in with $type.');
    }
    return res;
  }
}
