import 'package:ace/camera.dart';
import 'package:ace/createpost.dart';
import 'package:ace/feed.dart';
import 'package:ace/map.dart';
import 'package:ace/rewards.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _index = 0;

  List<Widget> _screens = [
    Feed(),
    CPost(),
    Camera(),
    Map(),
    Rewards(),
  ];

  final items = <Widget>[
    Icon(Icons.home, size: 30,),
    Icon(Icons.post_add, size: 30,),
    Icon(Icons.camera, size: 30,),
    Icon(Icons.map, size: 30,),
    Icon(Icons.card_giftcard, size: 30,),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
              bottom: 15,
              child: IndexedStack(
                index: _index,
                children: _screens,
              )
          )
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          color: Color(0xFF1C1C1C),
          buttonBackgroundColor: Color(0xFFFE3044),
          backgroundColor: Colors.transparent,
          items: items,
          height: 60,
          index: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
      ),
    );
  }
}
