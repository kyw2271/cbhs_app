import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class ErrorCard extends StatelessWidget {
  String errorString;
  double size;

  ErrorCard({@required this.errorString, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.xmark_circle,
              size: 110,
              color: Colors.grey,
            ),
            SizedBox(height: 30),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  errorString,
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
