import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

 double lat = 19.197092;
 double lang = 72.824563;

 @override
 void initState() {
   _location();
   super.initState();
 }


 Future<void> _location() async {

   Position position = await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high);
   double latitude = position.latitude;
   double longitude = position.longitude;

   List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
   Placemark place = placemarks.first;
   String address = "${place.name}, ${place.locality}, ${place.country}";

   setState(() {
     lat = latitude;
     lang = longitude;
   });

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(lat, lang),
            initialZoom: 15,
            interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
          ),
          children: [
            openStreetMapTileLayer,
            MarkerLayer(markers: [
            Marker(
                point: LatLng(19.197092, 72.824563),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
                CupertinoIcons.bin_xmark_fill,
              size: 30,
              color: Colors.red,
            )),
          ]),
      ],
    ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);

