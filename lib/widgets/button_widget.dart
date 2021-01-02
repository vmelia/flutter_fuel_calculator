import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    @required this.controlKey,
    @required this.text,
    @required this.isEnabled,
    @required this.onPressed,
  });

  final Key controlKey;
  final String text;
  final bool Function() isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: controlKey,
      onPressed: isEnabled() ? onPressed : null,
      color: Theme.of(context).primaryColorDark,
      textColor: Theme.of(context).primaryColorLight,
      child: Text(
        text,
        textScaleFactor: 1.5,
      ),
    );
  }
}
