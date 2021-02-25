import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:omnyomnyom/loginPage.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var setting = Hive.box('setting');
  List<String> location = ["선택없음", "서서울관", "동서울관", "청주관"];
  int id = 0000;

  int result = 0;
  bool fingerPrint = false;

  void actionsheet(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose Options'),
          message: const Text('Your options are '),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('서서울관'),
              onPressed: () {
                result = 1;
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('동서울관'),
              onPressed: () {
                result = 2;
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('청주관'),
              onPressed: () {
                result = 3;
                Navigator.pop(context);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              result = 0;
              Navigator.pop(context);
            },
          )),
    );

    debugPrint(result.toString());
    setting.put('location', result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "설정",
            style: TextStyle(fontSize: 18),
          ),
        ),
        child: Container(
            padding: EdgeInsets.only(bottom: 50),
            color: Color(0xfff2f1f6),
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: '개인 설정',
                  titleTextStyle: TextStyle(fontSize: 16),
                  tiles: [
                    SettingsTile(
                      title: '학사 선택',
                      subtitle: location[result],
                      leading: Icon(CupertinoIcons.house),
                      onPressed: (BuildContext context) {
                        actionsheet(context);
                      },
                    ),
                    SettingsTile(
                      title: 'QR 출입 로그인 (서서울관)',
                      subtitle: setting.get('id').toString(),
                      leading: Icon(CupertinoIcons.qrcode),
                      onPressed: (BuildContext context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage()));
                      },
                    ),
                    // SettingsTile.switchTile(
                    //   title: 'Use fingerprint',
                    //   leading: Icon(Icons.fingerprint),
                    //   switchValue: fingerPrint,
                    //   onToggle: (bool value) {
                    //     setState(() {
                    //       fingerPrint = value;
                    //     });
                    //   },
                    // ),
                  ],
                ),
                SettingsSection(
                    title: '관하여',
                    titleTextStyle: TextStyle(fontSize: 16),
                    tiles: [
                      SettingsTile(
                        title: '관하여',
                        leading: Icon(CupertinoIcons.person),
                        onPressed: (BuildContext context) {
                          debugPrint(setting.get('id').toString());
                        },
                      ),
                      SettingsTile(
                        title: '버그 리포트',
                        leading: Icon(CupertinoIcons.pencil_outline),
                        onPressed: (BuildContext context) {
                          debugPrint("Mail URI");
                        },
                      ),
                    ])
              ],
            )));
  }
}

/*

void _cupertinoPicker_DormitoryType(BuildContext context) async {
    await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              height: 250,
              child: Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Container(
                      color: Color.fromARGB(255, 232, 238, 245),
                      alignment: Alignment.centerRight,
                      height: 49,
                      child: CupertinoButton(
                        child: Text("선택"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                  Container(
                    height: 200,
                    child: CupertinoPicker(
                      backgroundColor: Color.fromARGB(255, 206, 211, 219),
                      itemExtent: 50,
                      onSelectedItemChanged: (int value) {
                        switch (value) {
                          case 0:
                            return result = 1;
                          case 1:
                            return result = 2;
                          default:
                            return result = 3;
                        }
                      },
                      children: [
                        Center(child: Text("서서울관")),
                        Center(child: Text("동서울관")),
                        Center(child: Text("청주관"))
                      ],
                    ),
                  ),
                ],
              ));
        });
    debugPrint(result.toString());
    setting.put('location', result.toString());
  }

*/
