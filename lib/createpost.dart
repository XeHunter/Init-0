import 'package:flutter/material.dart';

import 'cards.dart';

class CPost extends StatefulWidget {
  const CPost({super.key});

  @override
  State<CPost> createState() => _CPostState();
}

class _CPostState extends State<CPost> {

  List<String> img = [
    "assets/kachra.jpeg",
    "assets/kachra1.jpeg",
    "assets/kachra2.jpeg",
    "assets/kachra3.jpeg",
    "assets/kachra4.jpeg",
    "assets/kachra5.jpeg",
  ];

  List<String> location = [
    "Ghatkopar",
    "Thane",
    "Kalyan",
    "Malad",
    "Andheri",
    "Kurla",
  ];

  List<String> name = [
    "Aditi",
    "Aryan",
    "Shivam",
    "Dhruv",
    "Vaibhav",
    "Guest",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.topCenter,
            child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index){
                return Cards(imagePath: img[index], location: location[index], by: 'by', name: name[index]);
              },
            ),
        )
        ),
    );
  }
}
