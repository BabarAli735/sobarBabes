import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/utills/utills.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isloading = false;
  String _verificationId = '';
final _db = FirebaseFirestore.instance;
  bool get loading => _isloading;
  String get varifiedId => _verificationId;
 final FirebaseAuth _auth = FirebaseAuth.instance;
  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setverificationId(String value) {
    _verificationId = value;
    notifyListeners();
  }

  void sighnUpWithPhoneNumber(context, String number) async {
    print(number);
    if (number.isEmpty) {
      Utils.flushBarErrorMessage('Please Enter Valid Number', context);
      return;
    }
    // if (!Utils.isValidPhoneNumber(number)) {
    //   Utils.flushBarErrorMessage('Please Enter Valid Number', context);
    //   return;
    // }
    setLoading(true);
try {
    
      await _auth.verifyPhoneNumber(
        phoneNumber: '',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          // Utils.flushBarErrorMessage('verificationFailed $e', _context!);
          setLoading(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          setverificationId(verificationId);
          setLoading(false);
        
        },
        codeAutoRetrievalTimeout: (String verificationId) {
           setLoading(false);
        },
      );
    } catch (e) {
      // ignore: avoid_print
      // print("Error signing up with phone number: $e");
      Utils.toastMessage(e.toString());
      return null;
    }
    return null;
  }

  Future<User?> verifPhoneNumberOtp(
      BuildContext context, String otp, String phoneNumber) async {
//     try {
//       setLoading(true);
//       User? newUser = await auth.verifyOtp(otp);
     
//       if (newUser != null) {
        
//         try {
          
//           UserModel userModel =
//               await UserRepository().getUserDetail(phoneNumber);
 
//  await AccessTokenManager.saveAccessToken(newUser.toString());
//         await AccessTokenManager.savePhoneNumber(
//             newUser.phoneNumber.toString());
//           // ignore: use_build_context_synchronously
//           Navigator.pushNamedAndRemoveUntil(
//               context, RoutesName.BottomNavBar, (route) => false);
//           setLoading(false);
//         } catch (e) {
//           // ignore: use_build_context_synchronously
//           Navigator.pushNamedAndRemoveUntil(
//               context,
//               RoutesName.PersonalDetail,
//               arguments: phoneNumber,
//               (route) => false);

//           setLoading(false);
//         }
//       }
    // } catch (e) {
    //   setLoading(false);
    //   // Handle the error, show a message, or navigate to an error screen.
    //   Utils.toastMessage('Error during OTP verification: $e');
    // }
     try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: varifiedId, // Get the verification ID
        smsCode: otp,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      return authResult.user;
      
    } catch (e) {
      // ignore: avoid_print
      // Utils.flushBarErrorMessage("Error verifying OTP: $e", _context!);
      setLoading(false);
      return null;
    }
  }

  void resendOtp(context, String number) async {
    setLoading(true);
    // await auth.signUpWithPhoneNumber(number, true);
  }

  Future<void> createUser(UserModel userModel) async {
  

  createUser(UserModel user) {
    _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(() => () {
              Utils.toastMessage('Your Account has been successfully created');
            })
        .catchError((error, stackTrace) {
      Utils.toastMessage('Something went wrong try again');
    });
  }
}
}
