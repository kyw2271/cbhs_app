import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:omnyomnyom/locationScreen.dart';
import 'package:omnyomnyom/mealPage.dart';
import 'package:omnyomnyom/qrPage.dart';
import 'package:omnyomnyom/settingPage.dart';

import 'package:http/http.dart' as http;

import 'SplashScreen.dart';
import 'menu.dart';

void main() async {
  // initialize Hive and opening Hive boxes..
  await Hive.initFlutter();
  await Hive.openBox('setting');
  var settingHive = Hive.box('setting');
  settingHive.put('location', "0");

  // check if location is "0"
  // if (settingHive.get('location') == "0") {
  //   runApp(LocationScreen());
  // } else {
  //   runApp(MyApp());
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Menu> menuList;

  Future splashScreen() async {
    // wait for Splash Screen..
    await Future.delayed(const Duration(seconds: 1));

    // load menu from server..
    var settingHive = Hive.box('setting');
    if (settingHive.get('location') != "0") {
      await http
          .get("http://cbhs-test.iptime.org:2271/menu/cbhs2")
          .then((value) {
        // debugPrint("Menu Test : " + utf8.decode(value.bodyBytes));
        ServerInput temp =
            new ServerInput.fromJson(jsonDecode(utf8.decode(value.bodyBytes)));

        menuList = temp.results;

        for (int i = 0; i < menuList.length; i++) {
          debugPrint(menuList[i].days);
        }
      });
    }
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
  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "홈"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.doc_plaintext), label: "식단"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.qrcode), label: "출입"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "설정"),
  ];

  List<Menu> menuList;

  MyHome({@required this.menuList});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 3,
        items: bottomItems,
        iconSize: 20,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return TempWidget();
          case 1:
            return MealPage(
              menuList: menuList,
            );
          case 2:
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
