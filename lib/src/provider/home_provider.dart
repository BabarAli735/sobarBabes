import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sobarbabe/src/models/nearby_models.dart';

class HomeProvider with ChangeNotifier {
  
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

  Future<List<NearByModel>> getNearByUsers() async {
    final snapshot= await _db.collection('NearBy').get();
     final userData = snapshot.docs.map((e) => NearByModel.fromSnapShot(e)).toList();
   print(userData);
    return userData;
  }
}
