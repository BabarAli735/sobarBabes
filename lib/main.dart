
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/routes/route_helper.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'dart:io' show Platform;
main() async {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(

        child: MaterialApp(
          title: 'Sobar Babes',
          theme: _appTheme(),
          initialRoute: RoutesName.TokenValidationScreen,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
   
  }
}

 ThemeData _appTheme() {
    return ThemeData(
      primaryColor:AppColors.primary,
      colorScheme: const ColorScheme.light().copyWith(
          primary:AppColors.primary,
          secondary: AppColors.secondary,
          background:AppColors.primary),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          errorStyle: const TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
          )),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: Platform.isIOS ? 0 : 4.0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
