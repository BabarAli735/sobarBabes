import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/models/nearby_models.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<NearByModel> nearByModel = <NearByModel>[];
  var token;
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
    getAccessToken();
  }

  getAccessToken() async {
    token = await AccessTokenManager.getNumber();
    setState(() {});
  }

  loadData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('NearBy').get();
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();
    data.forEach(
      (element) {
        // final Map<String, dynamic>? data = element as Map<String, dynamic>?;

        nearByModel.add(element as NearByModel);
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.black,
          title: BoldText(text: 'My Favorite')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favorite')
            .where('user', isEqualTo: token)
            .snapshots(),
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
              child: BoldText(text: 'No Record found',color: AppColors.black,),
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
                          color: AppColors.black),
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, RoutesName.UserDetail,
                          //     arguments: data['userId']);
                          print(data);
                        },
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
