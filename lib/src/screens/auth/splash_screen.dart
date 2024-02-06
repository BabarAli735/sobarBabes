import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/screens/auth/login.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});

    var token = await AccessTokenManager.getNumber();
 
    if (token != null && token.isNotEmpty) {
      // User is logged in, navigate to home screen
      Navigator.pushNamed(context, RoutesName.Home);
    } else {
      // User is not logged in, navigate to login screen
      Navigator.pushNamed(context, RoutesName.Welcome);
    }
    // ignore: use_build_context_synchronously
    // Check if context is available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
             color: Colors.white,
             
          image: DecorationImage(
            image: AssetImage(
              AppImages.background_image,
            ),
            fit: BoxFit.cover,
          ),
        ),
         
          padding: EdgeInsets.only(bottom: heightPercentageToDP(10, context)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppImages.logonew,
                      height: heightPercentageToDP(15, context),
                    ),
                    const SizedBox(height: 10),
                    const Text('Sobar Babes Club',
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                    const SizedBox(height: 5),
                    Text('Match with people around you',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 20),
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
