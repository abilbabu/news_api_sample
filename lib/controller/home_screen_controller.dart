import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_sample/model/home-screen_model.dart';

class HomeScreenController with ChangeNotifier {
  List<News> datalist = [];
  Future<void> getNews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=611e8cfbf20047299b22789e65adadb5");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Homescreenmodel resModel = homescreenmodelFromJson(response.body);
        datalist = resModel.articles ?? [];
      }
    } catch (e) {
      print("e");
    }
    notifyListeners();
  }
}
