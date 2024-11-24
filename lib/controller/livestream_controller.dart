import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_sample/model/livestream_model.dart';

class LivestreamController with ChangeNotifier {
  List<Article> datalist = [];
  bool isloading = false;
  Future<void> getlive() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=apple&from=2024-11-23&to=2024-11-23&sortBy=popularity&apiKey=611e8cfbf20047299b22789e65adadb5");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Livestreammodel resModel = livestreammodelFromJson(response.body);
        datalist = resModel.articles ?? [];
      }
    } catch (e) {
      print("e");
    }
    isloading = false;
    notifyListeners();
  }
}
