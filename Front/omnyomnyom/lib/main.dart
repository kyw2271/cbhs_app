import 'package:flutter/cupertino.dart';
import 'package:omnyomnyom/mealPage.dart';
import 'package:omnyomnyom/qrPage.dart';

import 'SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoApp(
  //     home: MyHome(),
  //   );
  // }

  Future splashScreen() async {
    // loading futures ...
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: splashScreen(),
      builder: (context, snapshot) {
        // Once complete, show applications.
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint("INITIALIZATION COMPLETE!");
          // Load Thumbnail Articles
          return CupertinoApp(
            home: MyHome(),
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
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "식단"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.airplane), label: "공지"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.qrcode), label: "출입"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "설정"),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottomItems,
        iconSize: 20,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return MealPage();
          case 1:
            return TempWidget();
          case 2:
            return QrPage();
          default:
            return ErrorWidget();
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
        child: Text("Temp page!"),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Error page!"),
      ),
    );
  }
}
