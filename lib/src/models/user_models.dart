import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String username;
  final String phoneNumber;
  final String address;
  final String ECNumber;
  final String profileImage;

  UserModel(
      {this.id,
      required this.email,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.ECNumber,
      required this.profileImage});
  toJson() {
    return {
      "email": email,
      "UserName": username,
      "phoneNumber": phoneNumber,
      "address": address,
      "ECNumber": ECNumber,
      "profileImage": profileImage,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return UserModel(
      id: documentSnapshot.id,
      email: data!['email'],
      username: data['UserName'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      ECNumber: data['ECNumber'],
      profileImage: data['profileImage'],
    );
  }
}
