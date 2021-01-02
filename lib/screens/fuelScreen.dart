import 'package:flutter/material.dart';
import 'package:flutter_fuel_calculator/widgets/button_widget.dart';
import 'package:flutter_fuel_calculator/widgets/edit_string_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fuel_calculator/view_models/fuel_view_model.dart';

class FuelScreen extends StatelessWidget {
  final double _formDistance = 5.0;

  final TextEditingController distanceController = TextEditingController();
  final TextEditingController distancePerUnitController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FuelViewModel>(context);

    var distanceField = EditStringWidget(
      key: Key('distanceField'),
      controller: distanceController,
      onChanged: (value) => viewModel.distanceText = value,
      labelText: 'Distance',
      hintText: 'E.g., 123',
    );
    var distancePerUnitField = EditStringWidget(
      key: Key('distancePerUnitField'),
      controller: distancePerUnitController,
      onChanged: (value) => viewModel.distancePerUnitText = value,
      labelText: 'Distance per Unit',
      hintText: 'E.g., 15',
    );
    var priceField = EditStringWidget(
      key: Key('priceField'),
      controller: priceController,
      onChanged: (value) => viewModel.priceText = value,
      labelText: 'Price',
      hintText: 'E.g., 1.65',
    );

    var currencyDropdown = DropdownButton<String>(
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
    );
    
    var submitButton = ButtonWidget(
        key: Key('submitButton'),
        text: 'Submit',
        isEnabled: () => viewModel.canSubmit,
        onPressed: () => viewModel.submit());

    var resetButton = ButtonWidget(
        key: Key('resetButton'),
        text: 'Reset',
        isEnabled: () => viewModel.canReset,
        onPressed: () {
          distanceController.text = '';
          distancePerUnitController.text = '';
          priceController.text = '';
          viewModel.reset();
        });

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
            child: distanceField,
          ),
          Padding(
            padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
            child: distancePerUnitField,
          ),
          Padding(
            padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
            child: priceField,
          ),
          Text(
            viewModel.totalCostText,
            key: Key('resultText'),
          ),
          currencyDropdown,
          Row(
            children: <Widget>[
              Expanded(
                child: submitButton,
              ),
              VerticalDivider(width: 20),
              Expanded(
                child: resetButton,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
