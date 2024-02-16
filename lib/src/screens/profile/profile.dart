import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/utills/utills.dart';
import 'package:sobarbabe/src/widgets/image_source_sheet.dart';
import 'package:sobarbabe/src/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel? userProfileData;
  late AuthenticationProvider authenticationProvider;
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schoolController = TextEditingController();
  final _jobController = TextEditingController();
  final _bioController = TextEditingController();
  final _username = TextEditingController();
  final _firebaseAuth = fire_auth.FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    super.initState();
    // Start the confetti loop

    authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    userProfileData = UserModel(
        userBio: '',
        userId: '',
        userPhoneNumber: '',
        userPhotoLink: '',
        userJobTitle: '',
        userStatus: '',
        username: '');
    _loadUserProfileData(authenticationProvider);
    // Use yourProvider here
    // For example: yourProvider.someMethod();
  }

  Future<void> _loadUserProfileData(
      AuthenticationProvider authenticationProvider) async {
    try {
      var token = await AccessTokenManager.getNumber();
      print('token====' + token.toString());
      UserModel userModel = await authenticationProvider.getUserDetail(token!);
      print('userModel===' + userModel.username);
      // Map<String, dynamic> userData = await fetchUserProfileData();

      setState(() {
        userProfileData = userModel;
      });
    } catch (error) {
      print('error===' + error.toString());
      // Handle any errors that may occur during data loading
      // print("Error loading user profile data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('userProfileData' + userProfileData!.username);

    /// Initialization
    var authProvider = Provider.of<AuthenticationProvider>(context);
    File file = authProvider.profileImage ?? File('default/path/to/image.jpg');
    String? data = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          title: Text("Edit Profile",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: responsivefonts(2.5, context),
                  fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: Stack(
          children: [
            Image.asset(
              AppImages.background_image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.black.withOpacity(.4)
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Profile photo
                      GestureDetector(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    userProfileData!.userPhotoLink),
                                radius: widthPercentageToDP(18, context),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),

                              /// Edit icon
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          /// Update profile image
                          Navigator.pushNamed(
                              context, RoutesName.EditProfileScreen);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text("profile photo",
                            style:
                                TextStyle(fontSize: 18, color: AppColors.white),
                            textAlign: TextAlign.center),
                      ),

                      /// Show gallery
                      // const UserGallery(),

                      const SizedBox(height: 20),

                      /// School field
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                            labelText: "User Name",
                            hintText: userProfileData!.username,
                            hintStyle: TextStyle(color: AppColors.white),
                            labelStyle: TextStyle(color: AppColors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabled: false,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widthPercentageToDP(5, context)),
                              // Border when not focused
                              borderSide: BorderSide(
                                  color: Colors.white), // Border color
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.person,
                                color: AppColors.white,
                              ),
                            )),
                        validator: (school) {
                          if (school == null) {
                            return "enter your relational status";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _schoolController,
                        decoration: InputDecoration(
                            labelText: "Status",
                            hintText: userProfileData!.userStatus,
                            hintStyle: TextStyle(color: AppColors.white),
                            labelStyle: TextStyle(color: AppColors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabled: false,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widthPercentageToDP(5, context)),
                              // Border when not focused
                              borderSide: BorderSide(
                                  color: Colors.white), // Border color
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.person,
                                color: AppColors.white,
                              ),
                            )),
                        validator: (school) {
                          if (school == null) {
                            return "enter your relational status";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Job title field
                      TextFormField(
                        controller: _jobController,
                        decoration: InputDecoration(
                            labelText: "job_title",
                            hintText: userProfileData!.userJobTitle,
                            hintStyle: TextStyle(color: AppColors.white),
                            labelStyle: TextStyle(color: AppColors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabled: false,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  widthPercentageToDP(5, context)),
                              // Border when not focused
                              borderSide: BorderSide(
                                  color: Colors.white), // Border color
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.person,
                                color: AppColors.white,
                              ),
                            )),
                        validator: (job) {
                          if (job == null) {
                            return "please enter your job title";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Bio field
                      TextFormField(
                        controller: _bioController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "bio",
                          hintText: userProfileData!.userBio,
                          hintStyle: TextStyle(color: AppColors.white),
                          labelStyle: TextStyle(color: AppColors.white),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabled: false,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                widthPercentageToDP(5, context)),
                            // Border when not focused
                            borderSide:
                                BorderSide(color: Colors.white), // Border color
                          ),
                        ),
                        validator: (bio) {
                          if (bio == null) {
                            return "please write your bio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          text: 'Save',
                          onPressed: () async {
                            // if (Utils.isNullOrEmpty(file as String?)) {
                            //   Utils.flushBarErrorMessage(
                            //       'Please Enter User Name', context);
                            //   return;
                            // }
                            if (Utils.isNullOrEmpty(_schoolController.text)) {
                              Utils.flushBarErrorMessage(
                                  'Please Enter User Name', context);
                              return;
                            }
                            if (Utils.isNullOrEmpty(_jobController.text)) {
                              Utils.flushBarErrorMessage(
                                  'Please Enter User Name', context);
                              return;
                            }
                            if (Utils.isNullOrEmpty(_bioController.text)) {
                              Utils.flushBarErrorMessage(
                                  'Please Enter User Name', context);
                              return;
                            }
                            authProvider.setLoading(true);
                            String image;
                            if (file != null) {
                              image = await authProvider.uploadingImage(file);
                            } else {
                              image = '';
                            }

                            UserModel userModel = UserModel(
                                userBio: _bioController.text,
                                userId: DateTime.now().toString(),
                                username: _username.text,
                                userPhoneNumber: data.toString(),
                                userPhotoLink: image.toString(),
                                userJobTitle: _jobController.text,
                                userStatus: _schoolController.text);
                            authProvider.createUser(userModel);
                            authProvider.setLoading(false);
                            await AccessTokenManager.saveAccessToken(
                                userModel.toString());
                            await AccessTokenManager.savePhoneNumber(
                                userModel.userPhoneNumber.toString());
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                                context, RoutesName.Home, (route) => false);
                          }),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          text: 'Logout',
                          onPressed: () async {
                            await AccessTokenManager.removeAccessToken();
                            Navigator.pushNamed(context, RoutesName.Welcome);
                            authenticationProvider.signOut();
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  /// Get image from camera / gallery
  void _selectImage(
      {required String imageUrl, required String path, authProvider}) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ImageSourceSheet(
        onImageSelected: (image) async {
          if (image != null) {
            /// Show progress dialog
            // _pr.show(_"processing");

            // /// Update profile image
            // await UserModel().updateProfileImage(
            //     imageFile: image, oldImageUrl: imageUrl, path: 'profile');
            // // Hide dialog
            // _pr.hide();
            // // close modal
            authProvider.setProfileImage(image);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  /// Update profile changes for TextFormField only
  void _saveChanges() {
    /// Update uer profile
    //   UserModel().updateProfile(
    //       userSchool: _schoolController.text.trim(),
    //       userJobTitle: _jobController.text.trim(),
    //       userBio: _bioController.text.trim(),
    //       onSuccess: () {
    //         /// Show success message
    //         successDialog(context,
    //             message: "profile_updated_successfully",
    //             positiveAction: () {
    //           /// Close dialog
    //           Navigator.of(context).pop();

    //           /// Go to profilescreen
    //           Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) =>
    //                   ProfileScreen(user: UserModel().user, showButtons: false)));
    //         });
    //       },
    //       onFail: (error) {
    //         // Debug error
    //         debugPrint(error);
    //         // Show error message
    //         errorDialog(context,
    //             message: _i18n
    //                 .translate("an_error_occurred_while_updating_your_profile"));
    //       });
  }
}
