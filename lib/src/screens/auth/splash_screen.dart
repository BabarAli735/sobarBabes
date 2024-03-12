import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/screens/auth/login.dart';
import 'package:sobarbabe/src/screens/auth/welcome.dart';
import 'package:sobarbabe/src/screens/home/BottomTab.dart';
import 'package:sobarbabe/src/screens/home/home.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isActivated = true;

  @override
  initState() {
    super.initState();
    _navigateToHome();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isActivated = false; // Toggle the value
      });
    });
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});

    var token = await AccessTokenManager.getNumber();
    print('token====' + token.toString());
    if (token != null && token.isNotEmpty) {
      // User is logged in, navigate to home screen
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomTab()), // Navigate to Login screen
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } else {
      // User is not logged in, navigate toR login screen

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const Welcome()), // Navigate to Login screen
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    }
    // ignore: use_build_context_synchronously
    // Check if context is available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/background_image.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.black.withOpacity(.4)
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AppImages.logonew,
                    width: 300.0,
                    height: 300.0,
                  ),
                  const SizedBox(height: 10),
                  // const Text('Sobar Babes Club',
                  //     style: TextStyle(
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white)),
                  const SizedBox(height: 5),
                  // Text('Match with people around you',
                  //     textAlign: TextAlign.center,
                  //     style:
                  //         const TextStyle(fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 20),
                  if (isActivated)
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor)),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
