# 📍 현재 리뉴얼 작업 중입니다.
[리뉴얼 Repository 바로가기](https://github.com/osori-develop/osori-app)

---

# 지역학사 식단 / 출입 앱, 오소리 제작

## VER 0.1.0
### [IOS](https://apps.apple.com/kr/app/%EC%98%A4%EC%86%8C%EB%A6%AC-%EC%B6%A9%EB%B6%81%ED%95%99%EC%82%AC-%EC%8B%9D%EB%8B%A8-qr-%EC%B6%9C%EC%9E%85-%EC%95%B1/id1556278144)
### [Android](https://play.google.com/store/apps/details?id=com.soen.osori)

## 구현 목표
   지역학사 홈페이지에 공지되어있는 식단,공지,출입 정보등을 보다 접근성이 쉽게 어플리케이션으로 포팅
   
   
## 구현 기능
1. 식사, 공지 파싱 엔진  및 기초 프론트/백엔드 서서울관 출입- ver 0.1
2. 식사 위젯 (아이폰, 안드로이드 native code)
3. 인터넷위치기반 이용 밥시간되면 노티
4. 점호 관련 공지 노티
5. 간단한 게시판 (층별, 공동구매, 자유)

## 분석

* 사용인원 - 동서울관 + 서서울관 + 청주관(예정) 약 700명 가량

### 홈페이지에서 파싱가능한 정보
    * 식단
    * 공지사항 - 점호, 기타 지원여부
    * 출입 QR - 암호화 (서서울관 )

### 인트라넷에서 파싱가능한 정보 ( 로그인: 학사번호 + 생년월일 ) 
    * 복귀시간
    * 층

## 개발 인원 및 역할 분담

### StationSoen
  * 프론트 엔드 전반
  * ux/ui 디자인
  * 파서 엔진 설계 -프론트단 qr
  * Git 관리
   
### kyw2271
  * 백 엔드 전반
  * PM
  * 백엔드 구조 설계
  * 파서 엔진 설계
  * Git 관리
  

## 개발 환경 및 구현 프레임 워크
### Front-end
* Flutter


### back-end
1. django 3.2 / django rest framework / sqlite
2. python 3.8
4. ba4 / requests / lxml - parser
5. IDE - pycharm / postman
6. Docker with AWS EC2


----------

## 버젼별 구현 기능 및 코드 리뷰

### ver 0.1 - 
- 식단 GUI 구현
- 식단 파싱 엔진 제작
- 식단 API 제작

#### Front
내용 작성

#### Back


------------

## References
### Flutter 구현 참고

###  django 구현 참고
* https://www.inflearn.com/course/%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%9E%A5%EA%B3%A0-%ED%80%B4%EC%A6%88%EC%95%B1-%EC%84%9C%EB%B2%84-%ED%92%80%EC%8A%A4%ED%83%9D
* https://wooogy-egg.tistory.com/category/%EA%B8%B0%EC%88%A0%EA%B0%9C%EB%B0%9C/Django
* https://parkhyeonchae.github.io/archives/3/
* https://opentutorials.org/course/3718

### json 파싱관련 - 식사, 공지 파싱 엔진

### ios&android native 위젯
* https://itnext.io/develop-an-ios-14-widget-in-flutter-with-swiftui-e98eaff2c606
