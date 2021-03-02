import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:osori/errorCard.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  var setting = Hive.box('setting');

  Future<int> loadQRcode(int id, int pw) async {
    int code;
    debugPrint("NOW FETCH QR FUNC");

    // Error .. no ID/PW ..
    if (id == 0 || pw == 0) {
      code = 0;
    } else {
      var url = "http://ai.allitc.com:8080/cbhs_web/login.do";
      var body = jsonEncode({"userId": id, "userPw": pw});

      await http
          .post(url,
              headers: <String, String>{'contentType': "application/json"},
              body: body)
          .then((value) {
        String aStr = value.body
            .replaceAll(new RegExp(r'[^0-9]'), ''); // Extract only numbers
        code = int.parse(aStr);
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
      child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(
              top: 70, bottom: 50), // padding for tab bar and navigation bar.
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                futureQRBuilder(),
              ],
            ),
          )),
    );
  }

  Widget futureQRBuilder() {
    return FutureBuilder(
      future: loadQRcode(
          int.parse(setting.get('id')), int.parse(setting.get('pw'))),
      builder: (context, snapshot) {
        // Once complete, show applications.
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint(
              "Personal Code in QR Builder : " + snapshot.data.toString());
          // Load Thumbnail Articles

          if (snapshot.data == 0) {
            return ErrorCard(errorString: "(서서울관) 설정 탭에서 로그인을 먼저 진행해주세요!");
          } else if (snapshot.data == null) {
            return ErrorCard(errorString: "로그인 정보에 오류가 있습니다!");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImage(
                  data: snapshot.data.toString(),
                  size: 300,
                ),
                Container(
                  height: 20,
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    "Personal Code : " + snapshot.data.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 100),
                    child: CupertinoButton(
                        child: Text(
                          "새로고침",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          setState(() {});
                        })),
              ],
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
