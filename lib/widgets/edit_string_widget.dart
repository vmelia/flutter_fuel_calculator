import 'package:flutter/material.dart';

class EditStringWidget extends StatelessWidget {
  const EditStringWidget({
    Key key,
    @required this.controller,
    @required this.onChanged,
    @required this.labelText,
    @required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: Theme.of(context).textTheme.headline6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}