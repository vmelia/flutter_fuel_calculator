import 'package:flutter/material.dart';
import 'package:flutter_fuel_calculator/screens/fuelScreen.dart';
import 'package:flutter_fuel_calculator/view_models/fuel_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(new FlutterUiApp());

class FlutterUiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip Cost Calculator",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: ChangeNotifierProvider(
        create: (context) => FuelViewModel(),
        child: FuelScreen(),
      ),
    );
  }
}
