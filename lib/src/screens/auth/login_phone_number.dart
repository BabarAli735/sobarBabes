import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/SvgIcon.dart';
import 'package:sobarbabe/src/widgets/custom_outlined_button.dart';
import 'package:sobarbabe/src/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../provider/auth_provider.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final _numberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // late final AuthenticationProvider _authenticationProvider;

  final String _initialSelection = 'US';
  String _phoneNumber = '';
  String? _phoneCode = '+1';
  String _verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber:
            '${_phoneCode}${_numberController.text}', // Replace with the user's phone number
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatic verification if the user's phone number is in the possession of the device
          await _auth.signInWithCredential(credential);
          // Navigate to the next screen or perform any action
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval callback
        },
        timeout: Duration(seconds: 60), // Timeout for user to enter the code
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    print(authProvider.varifiedId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          title: Text("Phone Number",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: responsivefonts(2.5, context),
                  fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: Stack(
          children: [
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
                child: SingleChildScrollView(
                  child: Container(
                    
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          AppImages.logonew,
                          height: heightPercentageToDP(20, context),
                        ),
                        const SizedBox(height: 10),
                        const Text("sign in with phone number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, color: AppColors.white)),
                        const SizedBox(height: 25),
                        const Text(
                            "please enter your phone number and we will send you a sms",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        const SizedBox(height: 22),

                        /// Form
                        Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _numberController,
                                decoration: InputDecoration(
                                    labelText: 'Phone number',
                                    hintText: 'Enter Phone number',
                                    labelStyle:
                                        TextStyle(color: AppColors.white),
                                    hintStyle:
                                        TextStyle(color: AppColors.white),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CountryCodePicker(
                                          alignLeft: false,
                                          textStyle:
                                              TextStyle(color: AppColors.white),
                                          initialSelection: _initialSelection,
                                          onChanged: (country) {
                                            /// Get country code
                                            _phoneCode = country.dialCode!;
                                          }),
                                    )),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                validator: (number) {
                                  // Basic validation
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomElevatedButton(
                                  text: 'CONTINUE',
                                  onPressed: () => {
                                        _phoneNumber =
                                            '${_phoneCode}${_numberController.text}',
                                        authProvider.sighnUpWithPhoneNumber(
                                          context,
                                          _phoneNumber,
                                        )
                                      }),
                              VerticalSpace(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
