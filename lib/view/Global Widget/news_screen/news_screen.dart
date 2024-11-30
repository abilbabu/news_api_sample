import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/bookMark_screen_controller.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? publishedAt;
  final String descrbtion;
  final String content;
  final String url;

  NewsScreen({
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.publishedAt,
    required this.descrbtion,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Express Shorts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        actions: [
          const Icon(Icons.share),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              final news = {
                "title": title,
                "content": content,
                "descrbtion": descrbtion,
                "imageUrl": imageUrl,
                "publishedAt": publishedAt ?? "No date available",
                "url": url,
                "id": DateTime.now().millisecondsSinceEpoch
              };
              context.read<BookmarkScreenController>().addNews(news);
              context.read<BookmarkScreenController>().getStoreNews()
              ;
            },
            child: const Icon(Icons.bookmark_border_outlined),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 8),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Publish Date & Time | ${publishedAt ?? "No date available"}", // Null safety
                style: TextStyle(fontSize: 12, color: ColorConstants.darkgery),
              ),
              const SizedBox(height: 15),
              Text(
                descrbtion,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              Text(
                content,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {},
                child: Text(
                  url,
                  style: TextStyle(
                    color: ColorConstants.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
