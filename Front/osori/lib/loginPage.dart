import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:osori/component.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  double size;

  var qrLogin = Hive.box('setting');

  @override
  void initState() {
    print(qrLogin.get('size').runtimeType);
    size = qrLogin.get('size').toDouble();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color(0xfff2f1f6),
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "출입시스템 설정",
            style: TextStyle(fontSize: 18),
          ),
        ),
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 7),
                      decoration: basicBox,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                            "로그인",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          )),
                          Divider(),
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
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 7),
                      decoration: basicBox,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                            "QR 설정",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          )),
                          Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "QR 코드 크기",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${size.toInt()} px",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                )
                              ]),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 3),
                            child: CupertinoSlider(
                                value: size,
                                max: 300,
                                min: 100,
                                divisions: 200,
                                onChanged: (value) {
                                  setState(() {
                                    size = value;
                                  });
                                }),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 320,
                              width: 320,
                              child: Center(
                                child: QrImage(
                                  data: null.toString(),
                                  size: size,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: CircleButton(
                              width: double.infinity,
                              color: Colors.blue,
                              textColor: Colors.white,
                              text: "저장",
                              onPressed: () {
                                if (idController.text == "" ||
                                    pwController.text == "") {
                                  qrLogin.put('id', "0");
                                  qrLogin.put('pw', "0");
                                } else {
                                  qrLogin.put('id', idController.text);
                                  qrLogin.put('pw', pwController.text);
                                }
                                qrLogin.put('size', size);

                                Navigator.of(context).pop();
                              })),
                      // child: CupertinoButton(
                      //     child:
                      //         Text("로그인", style: TextStyle(fontSize: 20)),
                      //     onPressed: () {
                      //       if (idController.text == "" ||
                      //           pwController.text == "") {
                      //         qrLogin.put('id', "0");
                      //         qrLogin.put('pw', "0");
                      //       } else {
                      //         qrLogin.put('id', idController.text);
                      //         qrLogin.put('pw', pwController.text);
                      //       }

                      //       Navigator.of(context).pop();
                      //     })),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
