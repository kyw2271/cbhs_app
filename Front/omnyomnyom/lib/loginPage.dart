import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var qrLogin = Hive.box('setting');

    return CupertinoApp(
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: CupertinoPageScaffold(
            backgroundColor: Color(0xfff2f1f6),
            // navigationBar: CupertinoNavigationBar(
            //   middle: Text(
            //     "사생 번호 입력",
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "전자출입코드발급",
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Text(
                            "QR코드를 로드할 아이디와 비밀번호를 입력해주세요.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("사생 번호")),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 40,
                          child: CupertinoTextField(
                            placeholder: " \"-\" 을 제외하고 6자리로 입력해주세요.",
                            controller: idController,
                            autofocus: true,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("비밀번호")),
                      Container(
                          height: 40,
                          child: CupertinoTextField(
                            controller: pwController,
                            obscureText: true,
                            maxLength: 6,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            placeholder: "6자리 생년월일을 입력해주세요.",
                          )),
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: CupertinoButton(
                                child:
                                    Text("로그인", style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  if (idController.text == "" ||
                                      pwController.text == "") {
                                    qrLogin.put('id', "0");
                                    qrLogin.put('pw', "0");
                                  } else {
                                    qrLogin.put('id', idController.text);
                                    qrLogin.put('pw', pwController.text);
                                  }

                                  Navigator.of(context).pop();
                                })),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
