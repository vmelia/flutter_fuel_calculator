import 'package:flutter/material.dart';

class FuelViewModel with ChangeNotifier {
  final currencies = ['Euro', 'Dollars', 'Pounds'];
  double totalCost = 0.0;
  bool canSubmit;
  bool canReset;

  String _distanceText;
  String _distancePerUnitText;
  String _priceText;

  FuelViewModel() {
    _distanceText = "";
    _distancePerUnitText = "";
    _priceText = "";
  }

  // Settable values.
  String get distanceText => _distanceText;
  set distanceText(String value) {
    _distanceText = value;
    _calculate();
  }

  String get distancePerUnitText => _distancePerUnitText;
  set distancePerUnitText(String value) {
    _distancePerUnitText = value;
    _calculate();
  }

  String get priceText => _priceText;
  set priceText(String value) {
    _priceText = value;
    _calculate();
  }

  // Functions.
  void _calculate() {
    var _distance = double.parse(distanceText);
    var _distancePerUnit = double.parse(distancePerUnitText);
    var _price = double.parse(priceText);

    totalCost = calculateCost(_distance, _distancePerUnit, _price);

    canSubmit = distanceText.isNotEmpty &&
        distancePerUnitText.isNotEmpty &&
        priceText.isNotEmpty;

    canReset = distanceText.isNotEmpty ||
        distancePerUnitText.isNotEmpty ||
        priceText.isNotEmpty;

    notifyListeners();
  }

  void reset() {
    distanceText = "";
    distancePerUnitText = "";
    priceText = "";
    
    _calculate();
  }

  double calculateCost(double distance, double distancePerUnit, double price) {
    return distance / distancePerUnit * price;
  }
}
