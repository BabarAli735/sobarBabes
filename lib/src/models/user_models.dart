import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  
  final String userBio;
  final String userId;
  final String userPhoneNumber;
  final String userPhotoLink;
  final String userJobTitle;
  final String userStatus;
  final String username;

  UserModel(
      {
      required this.userBio,
      required  this.userId,
      required  this.userPhoneNumber,
      required  this.userPhotoLink,
      required  this.userJobTitle,
      required  this.userStatus,
      required  this.username,
      }
      
      
      );
      toJson() {
    return {
      "userBio": userBio,
      "userId": userId,
      "userPhoneNumber": userPhoneNumber,
      "userPhotoLink": userPhotoLink,
      "userJobTitle": userJobTitle,
      "userStatus": userStatus,
      "username": username,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return UserModel(
      userId: documentSnapshot.id,
      userBio: data!['userBio'],
      userPhoneNumber: data['userPhoneNumber'],
      userPhotoLink: data['userPhotoLink'],
      userJobTitle: data['userJobTitle'],
      userStatus: data['userStatus'],
      username: data['username'],
    );
  }
}
