import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/models/user.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/widgets/SvgIcon.dart';
import 'package:sobarbabe/src/widgets/dialogs/common_dialogs.dart';
import 'package:sobarbabe/src/widgets/image_source_sheet.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schoolController = TextEditingController();
  final _jobController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Initialization
    var authProvider = Provider.of<AuthenticationProvider>(context);
    print('+++++++' + authProvider.profileImage.toString());
    File file = authProvider.profileImage ?? File('default/path/to/image.jpg');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("edit_profile"),
          actions: [
            // Save changes button
            // TextButton(
            //   child: Text("SAVE",
            //       style: TextStyle(color: Theme.of(context).primaryColor)),
            //   onPressed: () {
            //     /// Validate form
            //     // if (_formKey.currentState!.validate()) {
            //     //   _saveChanges();
            //     // }
            //   },
            // )
          ],
        ),
        body: SingleChildScrollView(
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
                        authProvider.profileImage == null
                            ? CircleAvatar(
                                backgroundImage: const NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScGQQPJTeRXYxfbXVhLLXPl4aCJCexZ4dS7Q&usqp=CAU'),
                                radius: widthPercentageToDP(18, context),
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    widthPercentageToDP(35, context)),
                                child: Container(
                                  color: Colors
                                      .white, // Set the background color of the container
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: FileImage(file),
                                    height: widthPercentageToDP(35, context),
                                    width: widthPercentageToDP(35, context),
                                  ),
                                ),
                              ),

                        /// Edit icon
                        Positioned(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          right: 0,
                          bottom: 0,
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    /// Update profile image
                    _selectImage(
                        imageUrl: 'userModel.user.userProfilePhoto',
                        path: 'profile',
                        authProvider: authProvider);
                  },
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text("profile_photo",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                ),

                /// Show gallery
                // const UserGallery(),

                const SizedBox(height: 20),

                /// School field
                TextFormField(
                  controller: _schoolController,
                  decoration: const InputDecoration(
                      labelText: "school",
                      hintText: "enter your school name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(9.0),
                        child: SvgIcon("assets/icons/university_icon.svg"),
                      )),
                  validator: (school) {
                    if (school == null) {
                      return "please_enter_your_school_name";
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
                      hintText: "enter_your_job_title",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SvgIcon("assets/icons/job_bag_icon.svg"),
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
                  decoration: const InputDecoration(
                    labelText: "bio",
                    hintText: "write about you",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SvgIcon("assets/icons/info_icon.svg"),
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
                    onPressed: () {
                     String url= AuthenticationProvider().uploadFile(file: file, path: file.toString(), userId: '231') as String;
print('url======='+url);
//                 
//  User user
// =new User(userId: '123', userProfilePhoto: userProfilePhoto, userFullname: userFullname, userGender: userGender, userSexual: userSexual, userBirthDay: userBirthDay, userBirthMonth: userBirthMonth, userBirthYear: userBirthYear, userSobarDay: userSobarDay, userSobarMonth: userSobarMonth, userSobarYear: userSobarYear, userSchool: userSchool, userJobTitle: userJobTitle, userBio: userBio, userPhoneNumber: userPhoneNumber, userEmail: userEmail, userGallery: userGallery, userCountry: userCountry, userLocality: userLocality, userGeoPoint: userGeoPoint, userSettings: userSettings, userStatus: userStatus, userLevel: userLevel, userIsVerified: userIsVerified, userRegDate: userRegDate, userLastLogin: userLastLogin, userDeviceToken: userDeviceToken, userTotalLikes: userTotalLikes, userTotalVisits: userTotalVisits, userTotalDisliked: userTotalDisliked)                  AuthenticationProvider().createUser({
//                     'abc':'ss'
//                   });
                    })
              ],
            ),
          ),
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
