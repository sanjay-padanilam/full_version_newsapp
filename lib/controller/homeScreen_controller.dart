import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:full_version_newsapp/model/newsModel.dart';

import 'package:http/http.dart' as http;

class HomescreenController with ChangeNotifier {
  List<Article> everythinglist = [];

  List<Article> topheadlines = [];

  Future<void> getarticle() async {
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=41f5562ab4a641069301792a794fa8a9");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Newsmodel modelobj = newsmodelFromJson(response.body);
        everythinglist = modelobj.articlelist ?? [];
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> gettopHeadline() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=41f5562ab4a641069301792a794fa8a9");
    try {
      final response = await http.get(url);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        Newsmodel modelobj = newsmodelFromJson(response.body);
        topheadlines = modelobj.articlelist ?? [];
        log(topheadlines[0].title.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }
}
