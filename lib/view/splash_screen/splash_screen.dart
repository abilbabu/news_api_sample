import 'package:flutter/material.dart';
import 'package:news_api_sample/view/Bottomnavbar/bottomnavbar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Bottomnavbar(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Image.asset(height: 500, "asset/image/logonews.png"),
      ),
    );
  }
}
