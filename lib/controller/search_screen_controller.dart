import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_sample/model/home-screen_model.dart';


class SearchScreenController with ChangeNotifier {
  List<News> datalist = [];
  List<News> SearchDatalist = [];

  bool isloading = false;
  Future<void> getsearch() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=611e8cfbf20047299b22789e65adadb5");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
         Homescreenmodel resModel = homescreenmodelFromJson(response.body);
        datalist = resModel.articles ?? [];
        SearchDatalist = datalist;
      }
    } catch (e) {
      print("e");
    }
    isloading = false;
    notifyListeners();
  }

  void searchArticles(String query) {
    if (query.isEmpty) {
      SearchDatalist = datalist;
    } else {
      SearchDatalist = datalist
          .where((article) =>
              (article.title?.toLowerCase() ?? '')
                  .contains(query.toLowerCase()) ||
              (article.description?.toLowerCase() ?? '')
                  .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
