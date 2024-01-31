
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/screens/auth/login.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});
    // ignore: use_build_context_synchronously
   // Check if context is available
  if (mounted) {
    Navigator.pushNamed(context, RoutesName.Welcome );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: heightPercentageToDP(10, context)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Image.asset(AppImages.logonew,height: heightPercentageToDP(15, context),),
                  const SizedBox(height: 10),
                  const Text('Sobar Babes Club',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text('Match with people around you',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(valueColor:
      AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
