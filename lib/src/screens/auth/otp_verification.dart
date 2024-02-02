import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
String _verificationId = '';
 

    Future<void> _signInWithPhoneNumber(String smsCode) async {
      var user;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
     user=  await _auth.signInWithCredential(credential);
     print('user======'+user);
      // Navigate to the next screen or perform any action
    } catch (e) {
      print('Error: $e'); 
    }
  }
  String code = '';

  
  @override
  Widget build(BuildContext context) {
   String? varifiedId = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: widthPercentageToDP(3, context)),
          child: Column(
            children: [
              VerticalSpace(
                height: 5,
              ),
              Image.asset(
                AppImages.logonew,
                height: heightPercentageToDP(30, context),
                width: widthPercentageToDP(70, context),
              ),
              VerticalSpace(
                height: 2,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  code = verificationCode;
                }, // end onSubmit
              ),
              VerticalSpace(
                height: 8,
              ),
              CustomElevatedButton(
                  text: 'CONTINUE',
                  onPressed: () {
                    print('code======' + code.toString());
                    AuthenticationProvider().verifPhoneNumberOtp(context, code, varifiedId!);
                  }),
            ],
          )),
    );
  }
}
