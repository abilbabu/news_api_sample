import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/bookMark_screen_controller.dart';
import 'package:news_api_sample/controller/category_screen_controller.dart';
import 'package:news_api_sample/controller/home_screen_controller.dart';
import 'package:news_api_sample/controller/livestream_controller.dart';
import 'package:news_api_sample/controller/search_screen_controller.dart';
import 'package:news_api_sample/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookmarkScreenController.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LivestreamController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
