import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f1f6),
        resizeToAvoidBottomInset: false,
        appBar: CupertinoNavigationBar(
          heroTag: "boardPage",
          transitionBetweenRoutes: false,
          middle: Text(
            "게시판",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.separated(
                itemCount: 8,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return ArticleTile(
                      title: "공지사항",
                      replyNumber: 8,
                      article: "공지사항 내용 ////",
                    );
                  return ArticleTile(
                    title: "Hello World!",
                    replyNumber: 8,
                    article: "Welcome to new World ...",
                  );
                },
                separatorBuilder: (context, index) {
                  if (index == 0) return SizedBox.shrink();
                  return const Divider();
                },
              )),
        ));
  }
}

class ArticleTile extends StatelessWidget {
  String title;
  int replyNumber;
  String article;

  ArticleTile(
      {@required String title,
      @required int replyNumber,
      @required String article}) {
    this.title = title;
    this.replyNumber = replyNumber;
    this.article = article;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(article),
      trailing: Text(replyNumber.toString()),
    );
  }
}

class Article {
  int articleId;
  String title;
  int replyNumber;

  Article(String title, int replyNumber, int articleId) {
    this.articleId = articleId;
    this.title = title;
    this.replyNumber = replyNumber;
  }
}
