import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/category_screen_controller.dart';
import 'package:news_api_sample/view/Global%20Widget/news_screen/news_screen.dart';
import 'package:provider/provider.dart';

class Newslistscreen extends StatefulWidget {
  const Newslistscreen({super.key});

  @override
  State<Newslistscreen> createState() => _NewslistscreenState();
}

class _NewslistscreenState extends State<Newslistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<CategoryScreenController>(
                  builder: (context, newsObj, child) => newsObj.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsScreen(
                                      imageUrl:
                                          newsObj.dataList[index].urlToImage ??
                                              "",
                                      title: newsObj.dataList[index].title
                                          .toString(),
                                      publishedAt: newsObj
                                          .dataList[index].publishedAt
                                          .toString(),
                                      descrbtion: newsObj
                                          .dataList[index].description
                                          .toString(),
                                      content: newsObj.dataList[index].content
                                          .toString(),
                                      url: newsObj.dataList[index].url
                                          .toString(),
                                    ),
                                  ));
                            },
                            child: newsObj.dataList[index].urlToImage == null
                                ? SizedBox()
                                : Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(newsObj
                                                    .dataList[index].urlToImage
                                                    .toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    newsObj.dataList[index].url
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            newsObj.dataList[index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            newsObj.dataList[index].publishedAt
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          itemCount: newsObj.dataList.length,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
