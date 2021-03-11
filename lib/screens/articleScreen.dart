import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/userPro.dart';
import 'package:flutter_application_1/styles/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../functions/widgetFunction.dart';
import '../functions/widgetFunction.dart';
import '../navigations/navigationAnimation.dart';
import 'registrationScreen.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> getArticles(BuildContext context) async {
    final userPro = Provider.of<UserPro>(context, listen: false);
    if (userPro.articleModel.isEmpty) {
      final res = await userPro.getArticles();
      if (!res['status']) {
        showSnack(context, res['msg'], _scaffoldkey);
      }
    }
  }

  void logoutUser(BuildContext context) async {
    final userPro = Provider.of<UserPro>(context, listen: false);
    if (await userPro.logoutUser()) {
      showSnack(context, "User Logged out!", _scaffoldkey);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context)
            .pushReplacement(FadeNavigation(widget: RegistrationScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserPro>(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Articles',
          style: TextStyle(color: whiteTextColor),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => logoutUser(context))
        ],
      ),
      body: SafeArea(
          bottom: Platform.isIOS ? false : true,
          child: FutureBuilder(
            future: user.articleModel.isEmpty ? getArticles(context) : null,
            builder: (con, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserPro>(
                    builder: (con, userPro, _) => userPro.articleModel.isEmpty
                        ? Center(
                            child: Text("No Data!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        : Container(
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount:
                                    userPro.articleModel[0].articles.length,
                                itemBuilder: (con, index) {
                                  var data =
                                      userPro.articleModel[0].articles[index];
                                  return Card(
                                    color: Colors.black.withOpacity(0.08),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data.author.image),
                                                    fit: BoxFit.contain),
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data.title}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              buildSizedBoxHeight(8),
                                              Text(
                                                  "${formatter.format(DateTime.parse(data.createdAt))}"),
                                              buildSizedBoxHeight(8),
                                              Text(
                                                  "By: ${data.author.username}"),
                                              buildSizedBoxHeight(8),
                                              Text("${data.description}"),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  ),
          )),
    );
  }
}
