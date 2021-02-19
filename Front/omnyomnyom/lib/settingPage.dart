import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String result = "선택없음";

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
                            return result = "선택없음";
                          case 1:
                            return result = "서서울관";
                          case 2:
                            return result = "동서울관";
                          default:
                            return result = "청주관";
                        }
                      },
                      children: [
                        Center(child: Text("선택 없음")),
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
  }

  @override
  Widget build(BuildContext context) {
    bool value = true;
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
                      subtitle: result,
                      leading: Icon(Icons.house),
                      onPressed: (BuildContext context) {
                        _cupertinoPicker_DormitoryType(context);
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Use fingerprint',
                      leading: Icon(Icons.fingerprint),
                      switchValue: value,
                      onToggle: (bool value) {
                        setState(() {
                          value = false;
                          debugPrint(value.toString());
                        });
                      },
                    ),
                  ],
                ),
              ],
            )));
  }
}
