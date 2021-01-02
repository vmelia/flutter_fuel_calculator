import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.isEnabled,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool Function() isEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
