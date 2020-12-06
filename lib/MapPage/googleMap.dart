import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;

  LatLng _center;
  Position currentLocation;
  int color = 1;
  // final LatLng _center = const LatLng(46.769164, 23.589978);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // ignore: always_declare_return_types
  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $_center');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers.add(Marker(
          position: cordinate,
          markerId: MarkerId(id.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            (color == 1)
                ? BitmapDescriptor.hueRed
                : ((color == 2)
                    ? BitmapDescriptor.hueYellow
                    : BitmapDescriptor.hueGreen),
          )));
    });
  }

  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 130,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                      "Alegeti gradul de aglomeratie al locatiei curente")),
              Column(children: [
                Center(
                    heightFactor: 1,
                    widthFactor: 0.8,
                    child: Row(children: [
                      SizedBox(
                          width: (MediaQuery.of(context).size.width - 300) / 2),
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: RawMaterialButton(
                            onPressed: () => color = 1,
                          )),
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: RawMaterialButton(
                            onPressed: () => color = 2,
                          )),
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: RawMaterialButton(
                            onPressed: () => color = 3,
                          )),
                    ]))
              ])
            ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Crowded",
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Marker',
              onPressed: () {
                _showModalBottomSheet(context);
              },
            ),
          ],
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          markers: markers.toSet(),
          onTap: (cordinate) {
            addMarker(cordinate);
          },
        ),
      ),
    );
  }
}
