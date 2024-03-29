import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.background_image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Theme.of(context).primaryColor,
            Colors.black.withOpacity(.4)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// App logo
              Image.asset(
                AppImages.logonew,
                height: heightPercentageToDP(20, context),
              ),

              const SizedBox(height: 10),

              Text('Welcome',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white)),

              const SizedBox(height: 10),

              Text('Match with people around you',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white)),

              const SizedBox(height: 50),

              /// Sign in with Phone Number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      text: 'Login with phone number', onPressed: () {}),
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      text: 'Login with email', onPressed: () {}),
                ),
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                Text(
                  'Already have account',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
               
              ]),

              const SizedBox(
                height: 7,
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
