import 'package:flutter/material.dart';
import 'screens/fuelScreen.dart';

void main() => runApp(new FlutterUiApp());

class FlutterUiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip Cost Calculator",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new FuelScreen(),
    );
  }
}
