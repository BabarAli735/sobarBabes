import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/utills/utills.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isloading = false;
  String _verificationId = '';
    late User user;
  final _db = FirebaseFirestore.instance;
    final _firestore = FirebaseFirestore.instance;
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
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          // Utils.flushBarErrorMessage('verificationFailed $e', _context!);
          Utils.toastMessage(e.toString());
          setLoading(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          setverificationId(verificationId);
          setLoading(false);
          Navigator.pushNamed(context, RoutesName.OtpVerification,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setLoading(false);
        },
      );
    } catch (e) {
      Utils.toastMessage(e.toString());
      return null;
    }
    return null;
  }

  Future<User?> verifPhoneNumberOtp(
      BuildContext context, String otp, String id) async {
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
        verificationId: id, // Get the verification ID
        smsCode: otp,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      print(authResult.user!.phoneNumber.toString());
    } catch (e) {
      print('error verifPhoneNumberOtp' + e.toString());
      print('varifiedId' + _verificationId.toString());
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
                Utils.toastMessage(
                    'Your Account has been successfully created');
              })
          .catchError((error, stackTrace) {
        Utils.toastMessage('Something went wrong try again');
      });
    }
  }


    /// Add / Update profile image and gallery
  Future<void> updateProfileImage(
      {required File imageFile,
      String? oldImageUrl,
      required String path,
      int? index}) async {
    // Variables
    String uploadPath;

    /// Check upload path
    if (path == 'profile') {
      uploadPath = 'uploads/users/profiles';
    } else {
      uploadPath = 'uploads/users/gallery';
    }

    /// Delete previous uploaded image if not nul
    if (oldImageUrl != null) {
      await FirebaseStorage.instance.refFromURL(oldImageUrl).delete();
    }

    /// Upload new image
    // final imageLink = await uploadFile(
    //     file: imageFile, path: uploadPath, userId: user.userId);

  //   if (path == 'profile') {
  //     /// Update profile image link
  //     await updateUserData(
  //         userId: user.userId, data: {USER_PROFILE_PHOTO: imageLink});
  //   } else {
  //     /// Update gallery image
  //     await updateUserData(
  //         userId: user.userId, data: {'$USER_GALLERY.image_$index': imageLink});
  //   }
  }

    Future<void> updateProfile({
    required String userSchool,
    required String userJobTitle,
    required String userBio,
    // Callback functions
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    /// Update user profile
    // updateUserData(userId: user.uid, data: {
    //   USER_SCHOOL: userSchool,
    //   USER_JOB_TITLE: userJobTitle,
    //   USER_BIO: userBio,
    // }).then((_) {
    //   isLoading = false;
    //   notifyListeners();
    //   debugPrint('updateProfile() -> success');
    //   // Callback function
    //   onSuccess();
    // }).catchError((onError) {
    //   isLoading = false;
    //   notifyListeners();
    //   debugPrint('updateProfile() -> error');
    //   // Callback function
    //   onError(onError);
    // });
  }

    Future<void> updateUserData(
      {required String userId, required Map<String, dynamic> data}) async {
    // Update user data
    _firestore.collection('Users').doc(userId).update(data);
  }
}
