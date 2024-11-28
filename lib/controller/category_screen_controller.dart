import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:news_api_sample/model/category_screen_model.dart';


class CategoryScreenController with ChangeNotifier{
  String categoryIndex = "business";
  bool isLoading = false;
  List<String> category = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
    "politics"
  ];
  List<Article> dataList = [];

  Future getData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$categoryIndex&apiKey=e0533ab11900474fa12c7772251ca74b");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        CategoryScreenModel newsScreenRes = categoryScreenModelFromJson(response.body);
        dataList = newsScreenRes.articles ?? [];
      }
    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }
}