import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String title;
  final Function handler;

  const AdaptiveFlatButton({
    Key key,
    @required this.title,
    @required this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: handler)
        : FlatButton(
            onPressed: handler,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
