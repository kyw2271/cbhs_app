import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:osori/mealPage.dart';
import 'package:osori/qrPage.dart';
import 'package:osori/settingPage.dart';

import 'package:http/http.dart' as http;

import 'SplashScreen.dart';
import 'menu.dart';

void main() async {
  // initialize Hive and opening Hive boxes..
  await Hive.initFlutter();
  await Hive.openBox('setting');
  var settingHive = Hive.box('setting');

  List<String> hiveSetting = ['location', 'id', 'pw'];

  for (int i = 0; i < hiveSetting.length; i++) {
    if (settingHive.get(hiveSetting[i]) == null) {
      settingHive.put(hiveSetting[i], "0");
      settingHive.put('start', '2');
    }
  }
  if (settingHive.get('start') == null) {
    settingHive.put('start', '2');
  }

  // check if location is "0"
  // if (settingHive.get('location') == "0") {
  //   runApp(LocationScreen());
  // } else {
  //   runApp(MyApp());
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<List<Menu>> menuList = [null, null, null];

  Future splashScreen() async {
    // wait for Splash Screen..
    await Future.delayed(const Duration(seconds: 1));

    // load menu from server..
    for (int i = 1; i < 3; i++) {
      await http
          .get(
              "http://ec2-13-125-234-107.ap-northeast-2.compute.amazonaws.com:8000/menu/cbhs" +
                  i.toString())
          .then((value) {
        debugPrint("Menu Test : " + utf8.decode(value.bodyBytes));
        ServerInput temp =
            new ServerInput.fromJson(jsonDecode(utf8.decode(value.bodyBytes)));
        menuList[i] = temp.results;
      });
    }

    // if (settingHive.get('location') == "1" ||
    //     settingHive.get('location') == "2") {
    //   await http
    //       .get(
    //           "http://ec2-13-125-234-107.ap-northeast-2.compute.amazonaws.com:8000/menu/cbhs" +
    //               settingHive.get('location') +
    //               "/")
    //       .then((value) {
    //     debugPrint("Menu Test : " + utf8.decode(value.bodyBytes));
    //     ServerInput temp =
    //         new ServerInput.fromJson(jsonDecode(utf8.decode(value.bodyBytes)));

    //     menuList = temp.results;

    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: splashScreen(),
      builder: (context, snapshot) {
        // Once complete, show applications.
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint("Successfully load menu");
          // Load Thumbnail Articles
          return CupertinoApp(
            theme: CupertinoThemeData(brightness: Brightness.light),
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            home: MyHome(
              menuList: menuList,
            ),
          );
        }

        // if future has error, show error page.
        if (snapshot.hasError) {
          return CupertinoApp(
            title: "Error Page",
            home: CupertinoPageScaffold(
              child: Center(child: Text("ERROR!")),
            ),
          );
        }

        return SplashScreen();
      },
    );
  }
}

class MyHome extends StatelessWidget {
  var setting = Hive.box('setting');

  final List<BottomNavigationBarItem> bottomItems = [
    // BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "홈"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.doc_plaintext), label: "식단"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.qrcode), label: "출입"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "설정"),
  ];

  List<List<Menu>> menuList;

  MyHome({@required this.menuList});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: int.parse(setting.get('start')),
        items: bottomItems,
        iconSize: 20,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          // case 0:
          //   return TempWidget();
          case 0:
            return MealPage(
              menuList: menuList,
            );
          case 1:
            return QrPage();
          default:
            return SettingPage();
        }
      },
    );
  }
}

class TempWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Anounce page!"),
      ),
    );
  }
}
