import 'package:cloud_firestore/cloud_firestore.dart';

class NearByModel {
  final String Name;
  final String userId;
  final String age;
  final String image;
  final String relation;
  final String about;

  NearByModel({
    required this.userId,
    required this.Name,
    required this.about,
    required this.relation,
    required this.age,
    required this.image,
  });
  toJson() {
    return {
      "userId": userId,
      "Name": Name,
      "about": about,
      "relation": relation,
      "age": age,
      "image": image,
    };
  }

  factory NearByModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return NearByModel(
      userId: data!['userId'],
      Name: data!['Name'],
      relation: data['relation'],
      about: data['about'],
      age: data['age'],
      image: data['image'],
    );
  }
}
