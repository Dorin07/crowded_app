import 'package:flutter/material.dart';
import 'MapPage/googleMap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowded',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Map(),
      debugShowCheckedModeBanner: false,
    );
  }
}
