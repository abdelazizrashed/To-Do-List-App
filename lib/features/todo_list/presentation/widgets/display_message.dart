import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DisplayMessage extends StatelessWidget {
  final String message;
  final double fontSize;

  const DisplayMessage({
    Key key,
    @required this.message,
    this.fontSize = 50,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
