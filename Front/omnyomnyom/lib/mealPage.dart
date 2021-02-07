import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
      padding: EdgeInsets.only(bottom: 50),
      color: Color(0xfff2f1f6),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("식단"),
            border: Border(),
            backgroundColor: Color(0xfff2f1f6),
          ),
          SliverList(
            // 아이템을 빌드하기 위해서 delegate 항목을 구성함
            // SliverChildBuilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
            delegate: SliverChildBuilderDelegate((context, index) => MealCard(),
                childCount: 4),
          ),
        ],
      ),
    ));
  }
}

class MealCard extends StatelessWidget {
  String date = "2021년 01월 31일";
  String breakfast = "잡곡밥 부추올갱이국 고추잡채*꽃빵 배추김치 도토리묵*양념장 구운김 도라지무침 우유";
  String lunch = "잡곡밥 부추올갱이국 고추잡채*꽃빵 배추김치 도토리묵*양념장 구운김 도라지무침 우유";
  String dinner = "잡곡밥 부추올갱이국 고추잡채*꽃빵 배추김치 도토리묵*양념장 구운김 도라지무침 우유";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MealCardMenu(
                  meal: "아침",
                  menu: breakfast,
                  mealColor: Color(0xff18a030),
                ),
                MealCardMenu(
                  meal: "점심",
                  menu: lunch,
                  mealColor: Color(0xffe13d00),
                ),
                MealCardMenu(
                  meal: "저녁",
                  menu: dinner,
                  mealColor: Color(0xffc03d2c),
                ),
                SizedBox(height: 6)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MealCardMenu extends StatelessWidget {
  String meal;
  String menu;
  Color mealColor;

  MealCardMenu(
      {@required this.meal, @required this.menu, @required this.mealColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                meal,
                style: TextStyle(
                  fontSize: 18,
                  color: mealColor,
                  letterSpacing: 0.048,
                  fontWeight: FontWeight.w700,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                menu,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xff8d8c91),
                ),
              )),
        ],
      ),
    );
  }
}
