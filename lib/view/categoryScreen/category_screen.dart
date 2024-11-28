import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/category_screen_controller.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:news_api_sample/view/categoryScreen/widget/newslistScreen.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Map catlist = {
    "business": "asset/image/business.jpg",
    "entertainment": "asset/image/entertainment.jpeg",
    "general": "asset/image/general.jpg",
    "health": "asset/image/health.jpg",
    "science": "asset/image/science.jpg",
    "sports": "asset/image/sports.jpg",
    "technology": "asset/image/technologynews.jpg",
    "politics": "asset/image/political.webp",
  };

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<CategoryScreenController>().getData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Category News",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Consumer<CategoryScreenController>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String categoryName = value.category[index];
                        String imagePath = catlist[categoryName] ?? "";

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              value.categoryIndex = categoryName;
                              value.getData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Newslistscreen()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: ColorConstants.black,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categoryName,
                                      style: TextStyle(
                                        color: ColorConstants.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: value.category.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
