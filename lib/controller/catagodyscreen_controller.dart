import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:full_version_newsapp/model/newsModel.dart';
import 'package:http/http.dart' as http;

class CatagoryscreenController with ChangeNotifier {
  List<Article> topheadlines = [];
  bool isloading = false;

  static List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  static String selectedcatagory = "";

  Future<void> gettopHeadline() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$selectedcatagory&apiKey=41f5562ab4a641069301792a794fa8a9");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Newsmodel modelobj = newsmodelFromJson(response.body);
        topheadlines = modelobj.articlelist ?? [];
      }
    } catch (e) {}
    notifyListeners();
    isloading = false;
  }

  static void oncatagodyselection(int index) {
    selectedcatagory = CatagoryscreenController.categoryList[index];

    log(selectedcatagory.toString());
  }
}
