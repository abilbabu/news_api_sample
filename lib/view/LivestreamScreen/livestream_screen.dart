import 'package:flutter/material.dart';
import 'package:news_api_sample/controller/livestream_controller.dart';
import 'package:news_api_sample/utils/Color_Constants.dart';
import 'package:provider/provider.dart';

class LivestreamScreen extends StatefulWidget {
  const LivestreamScreen({super.key});

  @override
  State<LivestreamScreen> createState() => _LivestreamScreenState();
}

class _LivestreamScreenState extends State<LivestreamScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<LivestreamController>().getlive();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hotspot 24/7",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's News Live",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 10),
              Container(
                child: Expanded(
                  child: Consumer<LivestreamController>(
                    builder: (context, livecontroller, child) => livecontroller
                            .isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      livecontroller.datalist[index].title
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 230,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      livecontroller
                                                          .datalist[index]
                                                          .urlToImage
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        ColorConstants.lightGrey
                                                            .withOpacity(.7),
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      color:
                                                          ColorConstants.white,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                    livecontroller
                                                        .datalist[index].url
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstants
                                                            .lightGrey)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      livecontroller.datalist[index].publishedAt
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Divider(),
                                  ],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 12,
                                ),
                            itemCount: livecontroller.datalist.length),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
