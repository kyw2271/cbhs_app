import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:osori/component.dart';

import 'errorCard.dart';
import 'menu.dart';

class MealPage extends StatelessWidget {
  final List<List<Menu>> menuList;

  MealPage({@required this.menuList});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
      padding: EdgeInsets.only(bottom: 50),
      color: Color(0xfff2f1f6),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            heroTag: "mealPage",
            transitionBetweenRoutes: false,
            largeTitle: Text("식단"),
            border: Border(),
            backgroundColor: Color(0xfff2f1f6),
          ),
          checkCardList()
        ],
      ),
    ));
  }

  Widget checkCardList() {
    var setting = Hive.box('setting');

    // if location isnt selected,
    if (setting.get('location') == '0') {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: ErrorCard(
                    errorString: "설정 탭에서 학사를 먼저 선택해주세요!",
                    size: 250,
                  ),
                ),
            childCount: 1),
      );

      // if location is "서서울관" || "동서울관",
    } else if (setting.get('location') == '1' ||
        setting.get('location') == '2') {
      return SliverList(
        // 아이템을 빌드하기 위해서 delegate 항목을 구성함
        // SliverChildBuilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
        delegate: SliverChildBuilderDelegate(
            (context, index) => MealCard(
                  breakfast:
                      menuList[int.parse(setting.get('location'))][index].b,
                  lunch: menuList[int.parse(setting.get('location'))][index].l,
                  dinner: menuList[int.parse(setting.get('location'))][index].d,
                  date:
                      menuList[int.parse(setting.get('location'))][index].days,
                ),
            childCount: 7),
      );

      // if location is "청주관",
    } else if (setting.get('location') == '3') {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: ErrorCard(
          errorString: "Something Wrong",
          size: 250,
        ),
      );
      // else, There's something Wrong!
    } else {
      return ErrorCard(
        errorString: "Something Wrong",
        size: 250,
      );
    }
  }
}

class MealCard extends StatelessWidget {
  String date;
  String breakfast;
  String lunch;
  String dinner;

  MealCard(
      {@required this.date,
      @required this.breakfast,
      @required this.lunch,
      @required this.dinner});

  Widget isToday(String date) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    if (formattedDate == date) {
      return Icon(
        CupertinoIcons.checkmark_seal,
        color: Colors.green,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: basicBox,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 22,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    isToday(date)
                  ],
                ),
                Divider(),
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

// {"count":7,"next":null,"previous":null,"results":[{"Days":"2021-02-21","B":"잡곡밥 배추된장국 소불고기 두부조림 파래자반무침 깍두기 식빵/슬라이스치즈 우유/시리얼 딸기잼/버터","L":"잡곡밥  호박고추장찌개  코다리무조림  분홍소시지전  리플샐러드  배추김치  과일","D":"비빔밥  청국장  계란후라이  오이맛살초무침  배추김치"},{"Days":"2021-02-22","B":"잡곡밥 북어무국 돈육춘장볶음 메추리알어묵조림 아삭이고추무침 배추김치 모닝빵 우유/시리얼 딸기잼/버터","L":"잡곡밥  팽이버섯장국  안동찜닭  시금치나물  마파가지  알타리김치  과일","D":"잡곡밥  맑은홍합국  돈대패콩나물볶음  계란말이  파래자반볶음  알타리김치"},{"Days":"2021-02-23","B":"소고기야채죽 꽈리고추멸치볶음 두부간장조림 무말랭이무침 배추김치 식빵/슬라이스치즈 우유/시리얼 딸기잼/버터","L":"라멘  유부초밥  방울토마토샐러드  구운계란  통배추겉절이  과일","D":"잡곡밥  계란파국  소고기떡찜  어묵야채볶음  애호박새우젓볶음  참나물  깍두기"},{"Days":"2021-02-24","B":"잡곡밥 수제비국 돈사태찜 참나물무침 무나물 배추김치 모닝빵 우유/시리얼 딸기잼/버터","L":"잡곡밥  동태알탕  돈육강정  오븐계란찜  청경채겉절이  배추김치  과일","D":"잡곡밥  우렁된장찌개  통삼겹오븐구이  콩나물파채무침  상추*쌈장  배추김치"},{"Days":"2021-02-25","B":"잡곡밥 어묵무국 소불고기 연근조림 근대쌈장무침 배추김치 식빵/슬라이스치즈 우유/시리얼 딸기잼/버터","L":"수제치킨까스  브로콜리스프  꽃맛살사과샐러드  감자범벅  오이소박이  과일","D":"새우볶음밥  유부장국  순살파닭  청포묵김가루무침  배추김치  부럼"},{"Days":"2021-02-26","B":"프렌치토스트 스크램블에그 흑임자샐러드 과일","L":"오곡밥  소고기무국  닭갈비  삼색나물  구운김  찰떡  통배추겉절이","D":""},{"Days":"2021-02-27","B":"잡곡밥 콩나물된장국 오리훈제야채볶음 알감자조림 느타리버섯볶음 알타리김치 모닝빵 우유/시리얼 딸기잼/버터","L":"잡곡밥  육개장  닭굴소스볶음  섬초나물무침  새송이버섯볶음  배추김치  과일","D":"잡곡밥  오징어무국  삼치엿장조림  부추김치전  파래자반무침  배추김치"}]}
