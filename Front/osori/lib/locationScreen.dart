import 'package:flutter/cupertino.dart';

class LocationScreen extends StatelessWidget {
  void actionsheet(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose Options'),
          message: const Text('Your options are '),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('One'),
              onPressed: () {
                Navigator.pop(context, 'One');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Two'),
              onPressed: () {
                Navigator.pop(context, 'Two');
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              "학사 선택",
              style: TextStyle(fontSize: 18),
            ),
          ),
          child: Center(
            child: Text("Hello World!"),
          )),
    );
  }
}
