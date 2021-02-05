import 'package:flutter/material.dart';

Widget SplashScreen() {
  return MaterialApp(
    home: Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
            height: 10,
          ),
          Container(
              child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                // child: Image.asset("assets/images/logo_splash.png")
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ))
            ],
          )),
          SizedBox(
            width: 10,
            height: 10,
          ),
        ],
      )),
    ),
  );
}
