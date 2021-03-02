import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  String errorString;

  ErrorCard({@required this.errorString});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Icon(
              CupertinoIcons.xmark_circle,
              size: 112,
              color: Colors.grey,
            ),
            SizedBox(height: 30),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  errorString,
                  style: TextStyle(color: Colors.grey),
                ))
          ],
        ),
      ),
    );
  }
}
