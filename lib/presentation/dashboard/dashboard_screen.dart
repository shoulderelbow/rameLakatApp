import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:rame_lakat_app/presentation/dashboard/dashborad_screen_widget.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/News.dart';
import 'drawer.dart';


List<News> news = [];
List<News> filterNews = [];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getNews() async {
    news = await FirebaseApi.getNews();
    filterNews = await FirebaseApi.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      key: _scaffoldKey,
      appBar: appBar(_scaffoldKey, context),
      drawer: CustomDrawer(),
      body: FutureBuilder(
          future: getNews(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Dashboard_screen_widget();
            }
          }),
    );
  }
}
