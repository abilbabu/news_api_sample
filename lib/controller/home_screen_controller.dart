
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_sample/model/Home_Slidermodel.dart';
import 'package:news_api_sample/model/home-screen_model.dart';

class HomeScreenController with ChangeNotifier {
  List<News> datalist = [];
  bool isNewsloading = false;
  Future<void> getNews() async {
    isNewsloading = true;
    notifyListeners();
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
    isNewsloading = false;
    notifyListeners();
  }

  List<Article> SliderList = [];
  bool isloading = false;
  Future getheading() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=611e8cfbf20047299b22789e65adadb5");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {

        HomeSlidermodel resModel = homemodelFromJson(response.body);
        SliderList = resModel.articles ?? [];
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }
}
