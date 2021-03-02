import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  String appName;
  String appVersion;

  String developers;
  String logoDesigner;
  String githubLink;

  AboutPage(
      {@required this.appName,
      @required this.appVersion,
      @required this.developers,
      @required this.logoDesigner,
      @required this.githubLink});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: CupertinoPageScaffold(
            backgroundColor: Colors.white,
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                "정보",
                style: TextStyle(fontSize: 18),
              ),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset("assets/images/logo.png")),
                      SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Text(
                            appName + " : Version " + appVersion,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("Developers")),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            developers,
                            style: TextStyle(color: Colors.black54),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("Logo Design")),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(logoDesigner,
                              style: TextStyle(color: Colors.black54))),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("GitHub Link")),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(githubLink,
                              style: TextStyle(color: Colors.black54))),
                    ],
                  ),
                ),
              ),
            )));
  }
}
