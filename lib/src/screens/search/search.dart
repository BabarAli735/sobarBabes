import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
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
          child: Column(children: [
            SizedBox(height: heightPercentageToDP(3, context),),
            BoldText(text: 'Search Your Partner'),
            Container(
              margin: EdgeInsets.only(top: heightPercentageToDP(2, context)),
              padding: EdgeInsets.symmetric(horizontal: widthPercentageToDP(2, context)),
              child: TextField(
                controller: _searchController,
                
                decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIconColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color(0xFFAB47BC), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color(0xFFAB47BC), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          gapPadding: 0.0,
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color(0xFFAB47BC), width: 1.5),
                        ),
                        fillColor: const Color.fromARGB(101, 158, 158, 158),
                        filled: true,
                      ),
                onChanged: (value) {
                  // Perform search as the user types
                  print('Searching for: $value');
                },
              ),
            ),
          ]),
        )
      ],
    ));
  }
}