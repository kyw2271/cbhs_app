import 'package:flutter/Cupertino.dart';

Widget SplashScreen() {
  return CupertinoApp(
    home: CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 49, 115, 95),
      child: Center(
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
                  child: Image.asset("assets/images/logo.jpg")),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoActivityIndicator(
                    animating: true,
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
