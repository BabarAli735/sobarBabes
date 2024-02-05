import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/utills/utills.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isloading = false;
  String _verificationId = '';
  late User user;
  File? _profileImage;
  final _db = FirebaseFirestore.instance;
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = fire_auth.FirebaseAuth.instance;
  final _storageRef = FirebaseStorage.instance;
  fire_auth.User? get getFirebaseUser => _firebaseAuth.currentUser;
  final _fcm = FirebaseMessaging.instance;
  bool get loading => _isloading;
  File? get profileImage => _profileImage;
  String get varifiedId => _verificationId;
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

  Future<String> uploadFile( {
    required File file,
    required String path,
    required String userId,
  }) async {
    // Image name
    String imageName =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    // Upload file
    final UploadTask uploadTask = _storageRef
        .ref()
        .child(path + '/' + userId + '/' + imageName)
        .putFile(file);
    final TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();
    // return file link
    return url;
  }

  /// Get user from database => [DocumentSnapshot<Map<String, dynamic>>]
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) async {
    return await _firestore.collection(C_USERS).doc(userId).get();
  }

  Future<void> signUp({
    required File userPhotoFile,
    required String userFullName,
    required String userGender,
    required int userSobarDay,
    required int userSobarMonth,
    required int userSobarYear,
    required int userBirthDay,
    required int userBirthMonth,
    required int userBirthYear,
    required String userSchool,
    required String userJobTitle,
    required String userBio,
    // Callback functions
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    // Notify
    setLoading(true);
    notifyListeners();

    /// Set Geolocation point
    final userDeviceToken = await _fcm.getToken();

    /// Upload user profile image
    final String imageProfileUrl = await uploadFile(
        file: userPhotoFile,
        path: 'uploads/users/profiles',
        userId: getFirebaseUser!.uid);

    /// Save user information in database
    await _firestore
        .collection(C_USERS)
        .doc(getFirebaseUser!.uid)
        .set(<String, dynamic>{
      USER_ID: getFirebaseUser!.uid,
      USER_PROFILE_PHOTO: imageProfileUrl,
      USER_FULLNAME: userFullName,
      USER_GENDER: userGender,

      USER_SOBAR_DAY: userSobarDay,
      USER_SOBAR_MONTH: userSobarMonth,
      USER_SOBAR_YEAR: userSobarYear,

      USER_BIRTH_DAY: userBirthDay,
      USER_BIRTH_MONTH: userBirthMonth,
      USER_BIRTH_YEAR: userBirthYear,
      USER_SCHOOL: userSchool,
      USER_JOB_TITLE: userJobTitle,
      USER_BIO: userBio,
      USER_PHONE_NUMBER: getFirebaseUser!.phoneNumber ?? '',
      USER_EMAIL: getFirebaseUser!.email ?? '',
      USER_STATUS: 'active',
      USER_LEVEL: 'user',
      // User location info
      // USER_GEO_POINT: geoPoint.data,
      USER_COUNTRY: '',
      USER_LOCALITY: '',
      // End
      USER_LAST_LOGIN: FieldValue.serverTimestamp(),
      USER_REG_DATE: FieldValue.serverTimestamp(),
      USER_DEVICE_TOKEN: userDeviceToken,
      // Set User default settings
      USER_SETTINGS: {
        USER_MIN_AGE: 18, // int
        USER_MAX_AGE: 100, // int
        //USER_SHOW_ME: 'everyone',
        // USER_MAX_DISTANCE: AppModel().appInfo.freeAccountMaxDistance, // double
        USER_MAX_DISTANCE: 200, // double
      },
    }).then((_) async {
      /// Get current user in database
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await getUser(getFirebaseUser!.uid);

      /// Update UserModel for current user
      // updateUserObject(userDoc.data()!);

      /// Update loading status
      _isloading = false;
      notifyListeners();
      debugPrint('signUp() -> success');

      /// Callback function
      onSuccess();
    }).catchError((onError) {
      _isloading = false;
      notifyListeners();
      debugPrint('signUp() -> error');
      // Callback function
      onError(onError);
    });
  }
}
