import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/search_screen_controller.dart';
import 'package:news_api_sample/view/Global%20Widget/news_screen/news_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<SearchScreenController>().getsearch();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Search"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchScreenController>().searchArticles(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Consumer<SearchScreenController>(
                  builder: (context, newsObj, child) => newsObj.isloading
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
                                      imageUrl: newsObj.SearchDatalist[index]
                                              .urlToImage ??
                                          "",
                                      title: newsObj.SearchDatalist[index].title
                                          .toString(),
                                      publishedAt: newsObj
                                          .SearchDatalist[index].publishedAt
                                          .toString(),
                                      descrbtion: newsObj
                                          .SearchDatalist[index].description
                                          .toString(),
                                      content: newsObj
                                          .SearchDatalist[index].content
                                          .toString(),
                                      url: newsObj.SearchDatalist[index].url
                                          .toString(),
                                    ),
                                  ));
                            },
                            child: newsObj.SearchDatalist[index].urlToImage ==
                                    null
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
                                                    .SearchDatalist[index]
                                                    .urlToImage
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
                                                    newsObj
                                                        .SearchDatalist[index]
                                                        .url
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
                                            newsObj.SearchDatalist[index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            newsObj.SearchDatalist[index]
                                                .publishedAt
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
                          itemCount: newsObj.SearchDatalist.length,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
