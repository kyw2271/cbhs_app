import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:osori/component.dart';
import 'package:osori/errorCard.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  var setting = Hive.box('setting');

  Timer timer;

  Future<int> loadQRcode(String id, String pw) async {
    int code;
    // Error .. no ID/PW ..
    if (id == '0' || pw == '0') {
      code = 0;
    } else {
      var url = "http://ai.allitc.com:8080/cbhs_web/login.do";
      var body = '{\"userId\":' + id + ',\"userPw\":' + pw + '}';

      await http
          .post(url,
              headers: <String, String>{'contentType': "application/json"},
              body: body)
          .then((value) {
        String aStr = value.body;
        RegExp reg = new RegExp(r'[0-9]{1,10}');

        if (reg.firstMatch(aStr) == null) {
          debugPrint("Parameter Error - Invaild Account");
          code = null;
        } else {
          code = int.parse(reg.stringMatch(aStr));
        }
      });
    }
    debugPrint("Personal Code : " + code.toString());
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xfff2f1f6),
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        heroTag: "qrPage",
        transitionBetweenRoutes: false,
        middle: Text(
          "QR Code",
          style: TextStyle(fontSize: 18),
        ),
      ),
      child: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 14), // padding for tab bar and navigation bar.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 3, child: futureQRBuilder()),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: CircleButton(
                            width: double.infinity,
                            text: "새로고침",
                            onPressed: () {
                              setState(() {});
                            })))),
          ],
        ),
      )),
    );
  }

  Widget futureQRBuilder() {
    // print(setting.get('id') + " : " + setting.get('pw'));
    // print(jsonEncode({"userId": 123456, "userPw": 987654}));
    return FutureBuilder(
      future: loadQRcode(setting.get('id'), setting.get('pw')),
      builder: (context, snapshot) {
        // Once complete, show applications.
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint(
              "Personal Code in QR Builder : " + snapshot.data.toString());
          // Load Thumbnail Articles

          if (snapshot.data == 0) {
            return ErrorCard(
              errorString: "(서서울관)\n설정 탭에서 로그인\n먼저 진행해주세요!",
              size: 250,
            );
          } else if (snapshot.data == null) {
            return ErrorCard(
                errorString: "로그인 정보에 오류가 있습니다!", size: setting.get('size'));
          } else {
            return Container(
              decoration: basicBox,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: snapshot.data.toString(),
                      size: setting.get('size'),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Personal Code : " + snapshot.data.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        // if future has error, show error page.
        if (snapshot.hasError) {
          return Text("Error Here!");
        }

        return Center(
          child: SizedBox(
            width: 300,
            height: 320,
            child: CupertinoActivityIndicator(
              animating: true,
            ),
          ),
        );
      },
    );
  }
}

class Code {
  String data;

  Code({this.data});

  Code.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}
