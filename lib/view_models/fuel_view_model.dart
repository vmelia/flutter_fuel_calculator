import 'package:flutter/material.dart';

class FuelViewModel with ChangeNotifier {
  final currencies = ['Euro', 'Dollars', 'Pounds'];
  double totalCost;
  bool canSubmit = false;
  bool canReset = false;

  double _distance;
  double _distancePerUnit;
  double _price;
  String _currency;

  FuelViewModel() {
    _distance = null;
    _distancePerUnit = null;
    _price = null;
    _currency = currencies.first;
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
    canSubmit = distance != null && distancePerUnit != null && price != null;
    canReset = distance != null || distancePerUnit != null || price != null;

    notifyListeners();
  }

  void submit() {
    totalCost = calculateCost(_distance, _distancePerUnit, _price);

    notifyListeners();
  }

  void reset() {
    _distance = null;
    _distancePerUnit = null;
    _price = null;
    totalCost = 0.0;

    checkButtons();
  }

  double calculateCost(double distance, double distancePerUnit, double price) {
    return distance / distancePerUnit * price;
  }
}
