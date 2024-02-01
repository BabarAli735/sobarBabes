
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/screens/auth/login.dart';
import 'package:sobarbabe/src/screens/auth/login_phone_number.dart';
import 'package:sobarbabe/src/screens/auth/otp_verification.dart';
import 'package:sobarbabe/src/screens/auth/splash_screen.dart';
import 'package:sobarbabe/src/screens/auth/welcome.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.TokenValidationScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  SplashScreen(),
            settings: settings);
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  const Login(),
            settings: settings);
      case RoutesName.Welcome:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  const Welcome (),
            settings: settings);
      case RoutesName.LoginWithPhoneNumber:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  const LoginWithPhoneNumber(),
            settings: settings);
      case RoutesName.OtpVerification:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  const OtpVerification(),
            settings: settings);
  
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}