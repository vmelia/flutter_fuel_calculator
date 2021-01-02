import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/fuelScreen.dart';
import 'view_models/fuel_view_model.dart';

void main() => runApp(new FlutterUiApp());

class FlutterUiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip Cost Calculator",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: ChangeNotifierProvider(
          create: (context) => FuelViewModel(), child: FuelScreen()),
    );
  }
}
