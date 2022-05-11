import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/News.dart';
import '../../data/models/parameter.dart';
import 'drawer.dart';

List<News> news = [];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getNews() async {
    news = await FirebaseApi.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        key: _scaffoldKey,
        appBar: appBar(_scaffoldKey, context),
        body: SafeArea(
          child: Column(
            children: [
              toolbarView(AppStrings.newsLabel.tr()),
              Container(
                child: searchTextField(),
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              ),
              FutureBuilder(
                  future: getNews(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _listView();
                    }
                  })
            ],
          ),
        ),
        drawer: CustomDrawer());
  }

  Widget _listView() => Expanded(
    child: Container(
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 7, left: 7, right: 7, bottom: 0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(news[index].pictureLocation ?? ''), fit: BoxFit.cover, opacity: 0.8),
                  ),
                  child: InkWell(
                    onTap: () {
                      final parameter = Parameter(id: news[index].uniqueId ?? '');
                      Navigator.of(context).pushNamed('/individual_news', arguments: parameter);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(alignment: Alignment.topLeft),
                              Container(
                                decoration: (BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                )),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    news[index].type ?? '',
                                    style: TextStyle(color: Color(0xFF0B223D), fontSize: 30, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 120,
                          ),
                          Stack(
                            children: [
                              Align(alignment: Alignment.centerRight),
                              Container(
                                decoration: (BoxDecoration(color: Colors.white.withOpacity(0.5))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        news[index].name ?? '',
                                        style: TextStyle(color: Color(0xFF0B223D), fontSize: 25, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      "${news[index].date?.day.toString()}.${news[index].date?.month.toString()}.${news[index].date?.year.toString()}",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
  );
}
