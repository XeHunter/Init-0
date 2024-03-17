import 'package:ace/camera.dart';
import 'package:ace/createpost.dart';
import 'package:ace/feed.dart';
import 'package:ace/map.dart';
import 'package:ace/rewards.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _index = 0;

  String name = "Loading...";

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
  void initState() {
    _location();
    super.initState();
  }

  final picker = ImagePicker();

  Future<void> _location() async {

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;
      String address = "${place.name}, ${place.locality}, ${place.country}";

      setState(() {
        name = place.name!;
      });

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 4, // Adjust the elevation value according to the desired shadow size
        shadowColor: Colors.grey,
        title: Row(
          children: [
            Icon(Icons.location_on),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(name),
            )
          ],
        ),
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
          color: Colors.grey,
          buttonBackgroundColor: Colors.blueAccent,
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
