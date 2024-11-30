import 'package:flutter/material.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:provider/provider.dart';
import 'package:news_api_sample/controller/bookMark_screen_controller.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My News "),
      ),
      body: Consumer<BookmarkScreenController>(
        builder: (context, CartController, child) {
          // Check if the NewsStore is empty
          if (CartController.NewsStore.isEmpty) {
            return Center(
              child: Text(
                'No items in your cart!',
                style: TextStyle(fontSize: 18, color: ColorConstants.black),
              ),
            );
          }

          return ListView.builder(
            itemCount: CartController.NewsStore.length,
            itemBuilder: (context, index) {
              final newsItem = CartController.NewsStore[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorConstants.lightGrey,
                    image: DecorationImage(
                      image: NetworkImage(newsItem["imageUrl"]),
                      onError: (exception, stackTrace) {
                        // Handle errors here, like logging or showing an error icon
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                newsItem["title"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: ColorConstants.black,
                              ),
                              onPressed: () async {
                                await CartController.removeProduct(
                                    newsItem["id"]);
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5),
                          Text(
                            newsItem["publishedAt"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                          ),
                          Text(
                            newsItem["url"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
