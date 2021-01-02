import 'package:flutter/material.dart';
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

    var distanceField = TextField(
      key: Key('distanceField'),
      controller: distanceController,
      decoration: InputDecoration(
        labelText: 'Distance',
        hintText: 'E.g., 123',
        labelStyle: Theme.of(context).textTheme.headline6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        viewModel.distanceText = value;
      },
    );
    var distancePerUnitField = TextField(
      key: Key('distancePerUnitField'),
      controller: distancePerUnitController,
      decoration: InputDecoration(
        labelText: 'Distance per Unit',
        hintText: 'E.g., 15',
        labelStyle: Theme.of(context).textTheme.headline6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        viewModel.distancePerUnitText = value;
      },
    );
    var priceField = TextField(
      key: Key('priceField'),
      controller: priceController,
      decoration: InputDecoration(
        labelText: 'Price',
        hintText: 'E.g., 1.65',
        labelStyle: Theme.of(context).textTheme.headline6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        viewModel.priceText = value;
      },
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
    var submitButton = RaisedButton(
      key: Key('submitButton'),
      onPressed: viewModel.canSubmit
          ? () {
              viewModel.submit();
            }
          : null,
      color: Theme.of(context).primaryColorDark,
      textColor: Theme.of(context).primaryColorLight,
      child: Text(
        'Submit',
        textScaleFactor: 1.5,
      ),
    );
    var resetButton = RaisedButton(
      key: Key('resetButton'),
      onPressed: viewModel.canReset
          ? () {
              viewModel.reset();
              distanceController.text = '';
              distancePerUnitController.text = '';
              priceController.text = '';
            }
          : null,
      color: Theme.of(context).buttonColor,
      textColor: Theme.of(context).primaryColorDark,
      child: Text(
        'Reset',
        textScaleFactor: 1.5,
      ),
    );
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
