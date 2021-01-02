import 'package:flutter/material.dart';

class FuelScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  final _currencies = ['Euro', 'Dollars', 'Pounds'];
  final double _formDistance = 5.0;

  String _currency = 'Dollars';

  TextEditingController distanceController = TextEditingController();
  TextEditingController distancePerUnitController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String result = "";
  bool canSubmit = false;
  bool canReset = false;

  @override
  Widget build(BuildContext context) {
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
        setState(() {
          _enableDisableButtons();
        });
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
        setState(() {
          _enableDisableButtons();
        });
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
        setState(() {
          _enableDisableButtons();
        });
      },
    );
    var currencyDropdown = DropdownButton<String>(
      key: Key('currencyDropdown'),
      items: _currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: _currency,
      onChanged: (String value) {
        setState(() {
          _currency = value;
        });
      },
    );
    var submitButton = RaisedButton(
      key: Key('submitButton'),
      onPressed: canSubmit
          ? () {
              setState(() {
                result = _calculate();
              });
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
      onPressed: canReset
          ? () {
              setState(() {
                _reset();
              });
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
            result,
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

  void _enableDisableButtons() {
    canSubmit = distanceController.text.isNotEmpty &&
        distancePerUnitController.text.isNotEmpty &&
        priceController.text.isNotEmpty;

    canReset = distanceController.text.isNotEmpty ||
        distancePerUnitController.text.isNotEmpty ||
        priceController.text.isNotEmpty;
  }

  String _calculate() {
    var _distance = double.parse(distanceController.text);
    var _distancePerUnit = double.parse(distancePerUnitController.text);
    var _price = double.parse(priceController.text);

    var totalCost = _distance / _distancePerUnit * _price;
    return 'Total cost = ' + totalCost.toStringAsFixed(2) + ' ' + _currency;
  }

  void _reset() {
    distanceController.text = '';
    distancePerUnitController.text = '';
    priceController.text = '';
    setState(() {
      _enableDisableButtons();
      result = '';
    });
  }
}
