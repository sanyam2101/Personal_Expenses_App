import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function onPressFunction;

  AdaptiveFlatButton({this.buttonText, this.onPressFunction});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? FlatButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            textColor: Theme.of(context).accentColor,
            onPressed: onPressFunction,
          )
        : CupertinoButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: onPressFunction,
          );
  }
}
