import 'package:flutter/material.dart';

class FuelViewModel with ChangeNotifier {
  final currencies = ['Euro', 'Dollars', 'Pounds'];
  double totalCost = 0.0;
  String totalCostText = '';
  bool canSubmit = false;
  bool canReset = true;

  String _distanceText;
  String _distancePerUnitText;
  String _priceText;
  String _currency = 'Pounds';

  FuelViewModel() {
    _distanceText = "";
    _distancePerUnitText = "";
    _priceText = "";
  }

  // Settable values.
  String get distanceText => _distanceText;
  set distanceText(String value) {
    _distanceText = value;
    checkButtons();
  }

  String get distancePerUnitText => _distancePerUnitText;
  set distancePerUnitText(String value) {
    _distancePerUnitText = value;
    checkButtons();
  }

  String get priceText => _priceText;
  set priceText(String value) {
    _priceText = value;
    checkButtons();
  }

  String get currency => _currency;
  set currency(String value) {
    _currency = value;
    checkButtons();
  }

  // Functions.
  void checkButtons() {
    canSubmit = distanceText.isNotEmpty &&
        distancePerUnitText.isNotEmpty &&
        priceText.isNotEmpty;

    canReset = distanceText.isNotEmpty ||
        distancePerUnitText.isNotEmpty ||
        priceText.isNotEmpty;

    notifyListeners();
  }

  void submit() {
    var _distance = double.parse(distanceText);
    var _distancePerUnit = double.parse(distancePerUnitText);
    var _price = double.parse(priceText);

    totalCost = calculateCost(_distance, _distancePerUnit, _price);
    totalCostText = "Total cost = ${totalCost.toStringAsFixed(2)} $currency";

    notifyListeners();
  }

  void reset() {
    distanceText = "";
    distancePerUnitText = "";
    priceText = "";
    totalCost = 0.0;
    totalCostText = '';

    checkButtons();
  }

  double calculateCost(double distance, double distancePerUnit, double price) {
    return distance / distancePerUnit * price;
  }
}
