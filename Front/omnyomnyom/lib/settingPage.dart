import 'dart:convert';

import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:omnyomnyom/gloabal.dart';
import 'package:omnyomnyom/loginPage.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var setting = Hive.box('setting');
  List<String> location = ["선택없음", "서서울관", "동서울관", "청주관"];
  int id = 0000;

  int result;
  bool fingerPrint = false;

  void actionsheet(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Container(
            padding: EdgeInsets.only(top: 10),
            child: const Text(
              '학사 선택',
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          message: const Text('불러올 학사의 식단을 선택해주세요.'),
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
              Navigator.pop(context);
            },
          )),
    );

    // if result invaild value : cancel before select anything.
    if (result == null) {
      result = 0;
    }

    debugPrint("result : " + result.toString());
    setting.put('location', result.toString());
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'stationsoen@gmail.com',
        queryParameters: {'subject': '충북학사 버그 리포트', 'body': ''});
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          // Strange...
          heroTag: "settingPage",
          transitionBetweenRoutes: false,
          // Strange...
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
                      subtitle: location[int.parse(setting.get('location'))],
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
                          showAboutDialog(
                              context: context,
                              applicationVersion: "0.0.1",
                              applicationName: "충북학사",
                              applicationLegalese: "Hello World!",
                              applicationIcon: ImageIcon(
                                  AssetImage("assets/images/logo.jpg")));
                          debugPrint(setting.get('id').toString());
                        },
                      ),
                      SettingsTile(
                        title: '버그 리포트',
                        leading: Icon(CupertinoIcons.pencil_outline),
                        onPressed: (BuildContext context) {
                          launchEmailSubmission();
                        },
                      ),
                    ])
              ],
            )));
  }
}
