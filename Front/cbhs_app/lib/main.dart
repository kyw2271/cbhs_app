import 'package:cbhs_app/coloredSafeArea.dart';
import 'package:cbhs_app/splashScreen.dart';
import 'package:flutter/material.dart';

import 'bottomBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }

        // if future has error, show error page.
        if (snapshot.hasError) {
          return MaterialApp(
            title: "Error Page",
            home: Scaffold(
              body: Center(child: Text("ERROR!")),
            ),
          );
        }

        return SplashScreen();
      },
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.green,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ColoredSafeArea(
      color: Theme.of(context).accentColor,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: TabBarView(
            //physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(color: Colors.cyan))
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Text('Meal'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Notice'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('QR_Code'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Setting'),
                ),
              )
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
