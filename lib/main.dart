import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/home_screen_controller.dart';
import 'package:news_api_sample/controller/livestream_controller.dart';
import 'package:news_api_sample/view/Bottomnavbar/bottomnavbar.dart';
import 'package:provider/provider.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Bottomnavbar(),
      ),
    );
  }
}
