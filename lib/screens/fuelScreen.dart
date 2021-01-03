import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fuel_calculator/widgets/button_widget.dart';
import 'package:flutter_fuel_calculator/widgets/edit_string_widget.dart';
import 'package:flutter_fuel_calculator/view_models/fuel_view_model.dart';

class FuelScreen extends StatelessWidget {
  final double _formDistance = 5.0;

  final TextEditingController distanceController = TextEditingController();
  final TextEditingController distancePerUnitController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FuelViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
            child: EditStringWidget(
              controlKey: Key('distanceField'),
              controller: distanceController,
              onChanged: (value) => viewModel.distance = double.tryParse(value),
              labelText: 'Distance',
              hintText: 'E.g., 123',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
            child: EditStringWidget(
              controlKey: Key('distancePerUnitField'),
              controller: distancePerUnitController,
              onChanged: (value) =>
                  viewModel.distancePerUnit = double.tryParse(value),
              labelText: 'Distance per Unit',
              hintText: 'E.g., 15',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
            child: EditStringWidget(
              controlKey: Key('priceField'),
              controller: priceController,
              onChanged: (value) => viewModel.price = double.tryParse(value),
              labelText: 'Price',
              hintText: 'E.g., 1.65',
            ),
          ),
          Consumer<FuelViewModel>(
            builder: (_, viewModel, __) => Text(
              calculateResultText(viewModel.totalCost, viewModel.currency),
              key: Key('resultText'),
            ),
          ),
          DropdownButton<String>(
            key: Key('currencyDropdown'),
            items: viewModel.currencies.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: viewModel.currency,
            onChanged: (String value) {
              viewModel.currency = value;
            },
          ),
          Consumer<FuelViewModel>(
            builder: (_, viewModel, __) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonWidget(
                        controlKey: Key('submitButton'),
                        text: 'Submit',
                        isEnabled: () => viewModel.canSubmit,
                        onPressed: () => viewModel.submit()),
                  ),
                  VerticalDivider(width: 20),
                  Expanded(
                    child: ButtonWidget(
                      controlKey: Key('resetButton'),
                      text: 'Reset',
                      isEnabled: () => viewModel.canReset,
                      onPressed: () {
                        distanceController.text = '';
                        distancePerUnitController.text = '';
                        priceController.text = '';
                        viewModel.reset();
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ]),
      ),
    );
  }
}

String calculateResultText(double totalCost, String currency) {
  if (totalCost == null || currency == null) return "";
  return "Total cost = ${totalCost.toStringAsFixed(2)} $currency";
}
