import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  final List<Person> people = [
    Person(
      name: 'Jeniffer',
      job: 'Graphics Desighner',
      status: 'single',
      age: 20,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ5GVMa7gqvAj8yMNjWD7DueJPzlHuPelpjA&usqp=CAU',
    ),
    Person(
      name: 'Kajal',
       job: 'Mobile App Developer',
      status: 'In Relation',
      age: 25,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLtNoMsnotZFfFU8ha3Yj3_bJjuXVuSsDsZA&usqp=CAU',
    ),
    Person(
      name: 'Jenny',
       job: 'Shop Keeper',
      status: 'widow',
      age: 22,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuf9yS8GrmOC1gF6gzx9BwbsDjJ8DB4t35WQ&usqp=CAU',
    ),
    Person(
      name: 'Emma',
       job: 'Jobless',
      status: 'single',
      age: 21,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9OWToPqKj8ja3hlU1mKWq7ZsbslwqHE-gvg&usqp=CAU',
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: people.length,
            itemBuilder: (context, index) {
              return Container(
                width: widthPercentageToDP(93, context),
                margin: EdgeInsets.symmetric(
                    horizontal: widthPercentageToDP(3, context)),
                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.grey),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      people[index].imageUrl,
                      height: heightPercentageToDP(50, context),
                      fit: BoxFit.cover,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     people[index].name,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.white),
                    //   ),
                    // ),
                    Column(
                      children: [
                        Row(
                          children: [
                            MediumText(text: 'Name : '),
                            BoldText(text: people[index].name),
                          ],
                        ),
                        Row(
                          children: [
                            MediumText(text: 'Age : '),
                            BoldText(text: people[index].age.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            MediumText(text: 'Job : '),
                            BoldText(text: people[index].job.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            MediumText(text: 'Status : '),
                            BoldText(text: people[index].status.toString()),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}

class Person {
  final String name;
  final int age;
  final String imageUrl;
  final String job;
  final String status;

  Person(
      {required this.name,
      required this.imageUrl,
      required this.age,
      required this.job,
      required this.status});
}
