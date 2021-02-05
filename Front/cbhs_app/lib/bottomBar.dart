import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Container(
        height: 55,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 22,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
                size: 22,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.save_alt,
                size: 22,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.list,
                size: 22,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.list,
                size: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
