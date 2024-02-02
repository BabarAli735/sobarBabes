
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/widgets/gallery_image_card.dart';

class UserGallery extends StatelessWidget {
  const UserGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
            physics: const ScrollPhysics(),
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              /// Local variables
              String? imageUrl;
              BoxFit boxFit = BoxFit.none;

              dynamic imageProvider =
                  const AssetImage("assets/images/camera.png");

              // if (!userModel.userIsVip && index > 3) {
              //   imageProvider = const AssetImage("assets/images/crow_badge_small.png");
              // }

              /// Check gallery
              // if (userModel.user.userGallery != null) {
              //   // Check image index
              //   if (userModel.user.userGallery!['image_$index'] != null) {
              //     // Get image link
              //     imageUrl = userModel.user.userGallery!['image_$index'];
              //     // Get image provider
              //     imageProvider =
              //         NetworkImage(userModel.user.userGallery!['image_$index']);
              //     // Set boxFit
              //     boxFit = BoxFit.cover;
              //   }
              // }
              /// Show image widget
              return GalleryImageCard(
                imageProvider: imageProvider,
                boxFit: boxFit,
                imageUrl: imageUrl,
                index: index,
              );
            });
      }
    
  }

