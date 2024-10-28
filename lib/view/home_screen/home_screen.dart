import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeScreenController>().getNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, newsObj, child) => ListView.separated(
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsObj.datalist[index].title.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(newsObj
                                    .datalist[index].urlToImage
                                    .toString()),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            Text(newsObj.datalist[index].url.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        newsObj.datalist[index].publishedAt.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Divider(),
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 12,
                ),
            itemCount: newsObj.datalist.length),
      ),
    );
  }
}
