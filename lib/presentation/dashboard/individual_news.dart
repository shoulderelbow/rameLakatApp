import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/dashboard/individual_news_widget.dart';

import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/News.dart';
import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';



class IndividualNews extends StatefulWidget {
  const IndividualNews({Key? key, required this.parameter}) : super(key: key);
  final Parameter parameter;
  @override
  State<IndividualNews> createState() => _IndividualNewsState();
}

class _IndividualNewsState extends State<IndividualNews> {
  late News news;

  Future<void> getNews(String id) async {
    news = await FirebaseApi.getNew(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            }),
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getNews(widget.parameter.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blueAccent,
                    ),
                  ),
                );
              case ConnectionState.done:
                return IndividualNewsWidget(news: news);
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Result: ${snapshot.data}');
                }
            }
          }),
    );
  }
}
