import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/utills/utills.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isloading = false;
  String _verificationId = '';
  String _phoneNumber = '';
  late User user;
  File? _profileImage;
  final _db = FirebaseFirestore.instance;
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = fire_auth.FirebaseAuth.instance;
  final _storageRef = FirebaseStorage.instance;
  fire_auth.User? get getFirebaseUser => _firebaseAuth.currentUser;
  final _fcm = FirebaseMessaging.instance;
  static late final FirebaseStorage FSinstance;
  bool get loading => _isloading;
  File? get profileImage => _profileImage;
  String get varifiedId => _verificationId;
  String get phoneNumber => _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  setProfileImage(File value) {
    _profileImage = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setverificationId(String value) {
    _verificationId = value;
    notifyListeners();
  }

  setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void sighnUpWithPhoneNumber(
    context,
    String number,
  ) async {
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
           setLoading(false);
          var data = {'phoneNumber': number, 'id': verificationId};
          Navigator.pushNamed(
            context,
            RoutesName.OtpVerification,
            arguments: data,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setLoading(false);
        },
      );
    } catch (e) {
      Utils.toastMessage(e.toString());
      setLoading(false);
      return null;
    }
    return null;
  }

  Future<User?> verifPhoneNumberOtp(
      BuildContext context, String otp, String id, String phoneNumber) async {
    print('phoneNumber====' + phoneNumber.toString());
    try {
      setLoading(true);
      User? newUser = await verifyOtp(otp, id);
      print('phoneNumber====' + phoneNumber.toString());
      if (newUser != null) {
        try {
          UserModel userModel = await getUserDetail(phoneNumber);

          await AccessTokenManager.saveAccessToken(newUser.toString());
          await AccessTokenManager.savePhoneNumber(phoneNumber);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.Home, (route) => false);
          setLoading(false);
        } catch (e) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.EditProfileScreen,
              arguments: phoneNumber,
              (route) => false);

          setLoading(false);
        }
      }
    } catch (e) {
      setLoading(false);
      // Handle the error, show a message, or navigate to an error screen.
      Utils.toastMessage('Error during OTP verification: $e');
    }
  }

  void resendOtp(context, String number) async {
    setLoading(true);
    // await auth.signUpWithPhoneNumber(number, true);
  }

  Future<void> createUser(UserModel userModel) async {
    _db
        .collection('Users')
        .add(userModel.toJson())
        .whenComplete(() => () {
              Utils.toastMessage('Your Account has been successfully created');
            })
        .catchError((error, stackTrace) {
      Utils.toastMessage('Something went wrong try again');
    });
  }

  Future<void> updateUserData(
      {required String userId, required Map<String, dynamic> data}) async {
    // Update user data
    _firestore.collection('Users').doc(userId).update(data);
  }

  int calculateUserAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    // Get user age based in years
    int age = currentDate.year - birthDate.year;
    // Get current month
    int currentMonth = currentDate.month;
    // Get user birth month
    int birthMonth = birthDate.month;

    if (birthMonth > currentMonth) {
      // Decrement user age
      age--;
    } else if (currentMonth == birthMonth) {
      // Get current day
      int currentDay = currentDate.day;
      // Get user birth day
      int birthDay = birthDate.day;
      // Check days
      if (birthDay > currentDay) {
        // Decrement user age
        age--;
      }
    }
    return age;
  }

  Future<UserModel> getUserDetail(String phoneNumber) async {
    final snapshot = await _db
        .collection('Users')
        .where('userPhoneNumber', isEqualTo: phoneNumber)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData;
  }

  Future<String> uploadingImage(File image) async {
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    Reference refDirImage = _storageRef.ref().child('profile_images');
    Reference refUploaderDir = refDirImage.child(uniqueId);

    // Use the 'path' property to get the file path from the File object
    File imageFile = File(image.path);

    await refUploaderDir.putFile(imageFile);
    String url = await refUploaderDir.getDownloadURL();
    return url;
  }

  /// Get user from database => [DocumentSnapshot<Map<String, dynamic>>]
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) async {
    return await _firestore.collection(C_USERS).doc(userId).get();
  }

  // Verify OTP method
  Future<User?> verifyOtp(String otp, String varifiedId) async {
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
      Utils.toastMessage(e.toString());
      setLoading(false);
      return null;
    }
  }

  Future<void> signUpWithEmailAndPassword(
      email, password, name, context) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successfully signed in, you can navigate to the next screen or perform any other actions.
      print('User signed in: ${userCredential.user!.uid}');
      Navigator.pushNamed(context, RoutesName.EditProfileScreen,
          arguments: email);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Error: ${e.message}');
        Utils.flushBarErrorMessage(e.message.toString(), context);
      }
    }
  }

  Future<void> signInWithEmailAndPassword(email, password, context) async {
    try {
      
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Successfully signed in, you can navigate to the next screen or perform any other actions.
      print('User signed in: ${userCredential.user!.email.toString()}');
      await AccessTokenManager.savePhoneNumber(
          userCredential.user!.email.toString());
      Navigator.pushNamed(context, RoutesName.Home);
    } on FirebaseAuthException catch (e) {
     
      print(e);
      Utils.flushBarErrorMessage(e.toString(), context);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Error: ${e.message}');
        Utils.flushBarErrorMessage(e.message.toString(), context);
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('User signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
