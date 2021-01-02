import 'package:flutter/material.dart';

class FuelViewModel with ChangeNotifier {
  final currencies = ['Euro', 'Dollars', 'Pounds'];
  double totalCost = 0.0;
  String totalCostText = '';
  bool canSubmit = false;
  bool canReset = true;

  double _distance;
  double _distancePerUnit;
  double _price;
  String _currency = 'Pounds';

  FuelViewModel() {
    _distance = 0.0;
    _distancePerUnit = 0.0;
    _price = 0.0;
  }

  // Settable values.
  double get distance => _distance;
  set distance(double value) {
    _distance = value;
    checkButtons();
  }

  double get distancePerUnit => _distancePerUnit;
  set distancePerUnit(double value) {
    _distancePerUnit = value;
    checkButtons();
  }

  double get price => _price;
  set price(double value) {
    _price = value;
    checkButtons();
  }

  String get currency => _currency;
  set currency(String value) {
    _currency = value;
    checkButtons();
  }

  // Functions.
  void checkButtons() {
    canSubmit = distance > 0.0 &&
        distancePerUnit > 0.0 &&
        price > 0.0;

    canReset = distance > 0.0 ||
        distancePerUnit > 0.0 ||
        price > 0.0;

    notifyListeners();
  }

  void submit() {
    totalCost = calculateCost(_distance, _distancePerUnit, _price);
    totalCostText = "Total cost = ${totalCost.toStringAsFixed(2)} $currency";

    notifyListeners();
  }

  void reset() {
    _distance = 0.0;
    _distancePerUnit = 0.0;
    _price = 0.0;
    totalCost = 0.0;
    totalCostText = '';

    checkButtons();
  }

  double calculateCost(double distance, double distancePerUnit, double price) {
    return distance / distancePerUnit * price;
  }
}
