import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/apiConst.dart';
import 'package:flutter_application_1/models/articleMod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserPro with ChangeNotifier {
  bool isLogin;
  bool isLoading = false;

  //ArticleModel
  List<ArticleModel> articleModel = [];
  List<ArticleModel> get articleModelData {
    return [...articleModel];
  }

  Future<bool> isLoginUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("isLogin")) {
      return sharedPreferences.getBool("isLogin");
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> formData) async {
    try {
      toggleLoading(true);
      await http.post("$baseUrl + $userLogin", body: json.encode(formData));
      // print(res.body);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      isLogin = true;
      sharedPreferences.setBool("isLogin", isLogin);
      return reponseData(true, "User Login Success!");
    } catch (e) {
      print(e.toString() + " Error");
      return reponseData(false, "Something went wrong!");
    } finally {
      toggleLoading(false);
    }
  }

  Future<Map<String, dynamic>> getArticles() async {
    try {
      final res = await http.get(
        "https://conduit.productionready.io/api/articles",
      );
      final resp = json.decode(res.body);
      articleModel.add(ArticleModel.fromJson(resp));
      print(articleModel.length);
      return reponseData(true, "Fetched Success!");
    } catch (e) {
      print(e.toString() + " Error");
      return reponseData(false, "Something went wrong!");
    }
  }

  Future<bool> logoutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }

  void toggleLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Map<String, dynamic> reponseData(bool status, String msg) {
    return {"msg": msg, "status": status};
  }
}
