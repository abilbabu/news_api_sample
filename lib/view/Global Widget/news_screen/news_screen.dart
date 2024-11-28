import 'package:flutter/material.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';

class NewsScreen extends StatelessWidget {
  String imageUrl;
  String title;
  String? publishedAt;
  String descrbtion;
  String content;
  String url;
  NewsScreen(
      {required this.url,
      required this.imageUrl,
      required this.title,
      required this.publishedAt,
      required this.descrbtion,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Express shorts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Publish | $publishedAt!", style: TextStyle(fontSize: 12)),
              SizedBox(
                height: 15,
              ),
              Text(
                descrbtion,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                content,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                url,
                style: TextStyle(
                    color: ColorConstants.darkgery,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
