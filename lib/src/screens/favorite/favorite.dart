// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sobarbabe/src/constants/them.dart';
// import 'package:sobarbabe/src/models/nearby_models.dart';
// import 'package:sobarbabe/src/widgets/index.dart';

// class FavoriteScreen extends StatefulWidget {
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//    final List<NearByModel> n = <NearByModel>[];
//   var allData;
//   final List<Person> people = [
//     Person(
//       name: 'Jeniffer',
//       age: 20,
//       imageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ5GVMa7gqvAj8yMNjWD7DueJPzlHuPelpjA&usqp=CAU',
//     ),
//     Person(
//       name: 'Kajal',
//       age: 25,
//       imageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLtNoMsnotZFfFU8ha3Yj3_bJjuXVuSsDsZA&usqp=CAU',
//     ),
//     Person(
//       name: 'Jenny',
//       age: 22,
//       imageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuf9yS8GrmOC1gF6gzx9BwbsDjJ8DB4t35WQ&usqp=CAU',
//     ),
//     Person(
//       name: 'Emma',
//       age: 21,
//       imageUrl:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9OWToPqKj8ja3hlU1mKWq7ZsbslwqHE-gvg&usqp=CAU',
//     ),
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadData();
//   }

//   loadData() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('NearBy').get();
//     var data = querySnapshot.docs.map((doc) => doc.data()).toList();
//     data.forEach((element) {
//         final Map<String, dynamic>? data = element as Map<String, dynamic>?;
//         allData.add();
//     },);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(allData);
//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: AppColors.black,
//             title: BoldText(text: 'My Favorite')),
//         body: Stack(
//           children: [
//             Image.asset(
//               AppImages.background_image,
//               fit: BoxFit.cover,
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   colors: [
//                     Theme.of(context).primaryColor,
//                     Colors.black.withOpacity(.4)
//                   ],
//                 ),
//               ),
//               child: ListView.builder(
//                 itemCount: allData.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Image.network(
//                             allData[index].image,
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 allData[index].Name,
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.white),
//                               ),
//                               Text(
//                                 people[index].age.toString(),
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.white),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ));
//   }
// }

// class Person {
//   final String name;
//   final int age;
//   final String imageUrl;

//   Person({required this.name, required this.imageUrl, required this.age});
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/models/nearby_models.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
   final List<NearByModel> nearByModel = <NearByModel>[];
  var allData;
  final List<Person> people = [
    Person(
      name: 'Jeniffer',
      age: 20,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ5GVMa7gqvAj8yMNjWD7DueJPzlHuPelpjA&usqp=CAU',
    ),
    Person(
      name: 'Kajal',
      age: 25,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLtNoMsnotZFfFU8ha3Yj3_bJjuXVuSsDsZA&usqp=CAU',
    ),
    Person(
      name: 'Jenny',
      age: 22,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuf9yS8GrmOC1gF6gzx9BwbsDjJ8DB4t35WQ&usqp=CAU',
    ),
    Person(
      name: 'Emma',
      age: 21,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9OWToPqKj8ja3hlU1mKWq7ZsbslwqHE-gvg&usqp=CAU',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('NearBy').get();
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();
    data.forEach((element) {
        // final Map<String, dynamic>? data = element as Map<String, dynamic>?;
       print(element);
        nearByModel.add(element as NearByModel);
    },);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(nearByModel);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.black,
            title: BoldText(text: 'My Favorite')),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorite').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var document = snapshot.data!.docs[index];
                var data = document.data() as Map<String, dynamic>;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            data['image'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                data['Name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                              ),
                              Text(
                                people[index].age.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ));
              },
            );
          }
        },
      ),
    );
      
  }
}

class Person {
  final String name;
  final int age;
  final String imageUrl;

  Person({required this.name, required this.imageUrl, required this.age});
}

