import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/screens/favorite/favorite.dart';
import 'package:sobarbabe/src/screens/home/home.dart';
import 'package:sobarbabe/src/screens/profile/profile.dart';
import 'package:sobarbabe/src/screens/search/search.dart';

class BottomTab extends StatefulWidget {
  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab>
    with SingleTickerProviderStateMixin {
  // Initialize userProfileData with a default value
  late AuthenticationProvider authenticationProvider;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

   
  }




  @override
  Widget build(BuildContext context) {
   
    final List<Widget> _screens = [
      HomeScreen(),
      FavoriteScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.white,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.brown,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: AppColors.white),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: AppColors.white),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: AppColors.white),
            label: 'Profile',
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

// Function to fetch the current user's profile data
Future<Map<String, dynamic>> fetchUserProfileData() async {
  try {
    // var token = await AccessTokenManager.getNumber();
    // UserModel userModel = await authProvider.getUserDetail(token);
    // Step 1: Get the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    // Step 2: Check if a user is signed in
    if (user != null) {
      // Step 3: Get the user's UID
      String uid = user.uid;
      print('uid====' + uid.toString());
      // Step 4: Query Firestore to retrieve the user's profile data
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      print('userData===' + userSnapshot.toString());
      // Step 5: Check if the user document exists
      if (userSnapshot.exists) {
        // Step 6: Get the user data
        Map<String, dynamic> userData = userSnapshot.data()!;

        // Step 7: Return the user data
        return userData;
      } else {
        // Handle the case where the user document doesn't exist
        throw "User document does not exist";
      }
    } else {
      // Handle the case where no user is signed in
      throw "No user signed in";
    }
  } catch (error) {
    // Handle any errors that may occur
    print("Error fetching profile data: $error");
    throw error;
  }
}
