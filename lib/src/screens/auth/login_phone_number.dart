import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/SvgIcon.dart';
import 'package:sobarbabe/src/widgets/custom_outlined_button.dart';
import 'package:sobarbabe/src/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final _numberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String _initialSelection = 'US';
  String? _phoneCode = '+1';
String _verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+923113516459', // Replace with the user's phone number
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Phone Number"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: const SvgIcon("assets/icons/call_icon.svg",
                    width: 60, height: 60, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text("sign in with phone number",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              const SizedBox(height: 25),
              const Text(
                  "please enter your phone number and we will send you a sms",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CountryCodePicker(
                                alignLeft: false,
                                initialSelection: _initialSelection,
                                onChanged: (country) {
                                  /// Get country code
                                  _phoneCode = country.dialCode!;
                                }),
                          )),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      validator: (number) {
                        // Basic validation
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(text: 'CONTINUE', onPressed: () => {
                      // _verifyPhoneNumber()
                      Navigator.pushNamed(context,RoutesName.OtpVerification)
                    }),
                    VerticalSpace(),
                  
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}