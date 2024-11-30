import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/home_screen_controller.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:news_api_sample/view/Global%20Widget/news_screen/news_screen.dart';
import 'package:news_api_sample/view/Profile_screen/profile_screen.dart';
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
      (timeStamp) async {
        await context.read<HomeScreenController>().getheading();
        await context.read<HomeScreenController>().getNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
              },
              child: Icon(Icons.person_4_outlined)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(),
              SizedBox(height: 8),
              _buildSliderSection(),
              Divider(),
              SizedBox(height: 10),
              Text("Today's Crossword",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              _buildNewsListSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsListSection() {
    return Consumer<HomeScreenController>(
        builder: (context, newsObj, child) => newsObj.isNewsloading
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
                            imageUrl: newsObj.datalist[index].urlToImage ?? "",
                            title: newsObj.datalist[index].title.toString(),
                            publishedAt:
                                newsObj.datalist[index].publishedAt.toString(),
                            descrbtion:
                                newsObj.datalist[index].description.toString(),
                            content: newsObj.datalist[index].content.toString(),
                            url: newsObj.datalist[index].url.toString(),
                          ),
                        ));
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(newsObj
                                    .datalist[index].urlToImage
                                    .toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    newsObj.datalist[index].url.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            newsObj.datalist[index].title.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text(
                            newsObj.datalist[index].publishedAt.toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemCount: newsObj.datalist.length,
              ));
  }

  Widget _buildSliderSection() {
    return Consumer<HomeScreenController>(
        builder: (context, newsObj, child) => newsObj.isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 350,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: newsObj.SliderList.map((sliderItem) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsScreen(
                                  imageUrl: sliderItem.urlToImage ?? "",
                                  title: sliderItem.title.toString(),
                                  publishedAt:
                                      sliderItem.publishedAt.toString(),
                                  descrbtion: sliderItem.description.toString(),
                                  content: sliderItem.content.toString(),
                                  url: sliderItem.url.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                    sliderItem.urlToImage.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sliderItem.title.toString(),
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    sliderItem.publishedAt.toString(),
                                    style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ));
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "The Good\nNews Hub",
          style: TextStyle(
              fontSize: 20,
              color: ColorConstants.black,
              fontWeight: FontWeight.w700),
        ),
        Text(
          "Journalism of Courage.",
          style: TextStyle(
              fontSize: 12,
              color: ColorConstants.black,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
