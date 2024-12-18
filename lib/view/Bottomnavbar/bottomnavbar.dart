import 'package:flutter/material.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:news_api_sample/view/BookMarkScreen/bookmark_screen.dart';
import 'package:news_api_sample/view/LivestreamScreen/livestream_screen.dart';
import 'package:news_api_sample/view/categoryScreen/category_screen.dart';
import 'package:news_api_sample/view/home_screen/home_screen.dart';
import 'package:news_api_sample/view/searchScreen/searchScreen.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int selectedTab = 0;
  List screen = [
    HomeScreen(),
    CategoryScreen(),
    BookmarkScreen(),
    LivestreamScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        backgroundColor: ColorConstants.PrimaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
        },
        child: Icon(
          Icons.search,
          color: ColorConstants.white,
        ),
      ),
      body: screen[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTab,
          onTap: (value) {
            selectedTab = value;
            setState(() {});
          },
          selectedItemColor: ColorConstants.PrimaryColor,
          unselectedItemColor: ColorConstants.darkgery,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "For You",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome_mosaic_outlined),
                label: "News Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline), label: "Saved"),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv_sharp), label: "Live Stream"),
          ]),
    );
  }
}
