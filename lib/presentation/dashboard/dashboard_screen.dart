import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/News.dart';
import 'drawer.dart';

List<News> news = [];


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getNews() async {
    news = await FirebaseApi.getNews();
  }

  @override
  void initState() {
    getNews();
    super.initState();
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
              toolbarView(AppStrings.dashboardLabel.tr()),
              Container(
                child: searchTextField(),
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              ),
              Expanded(
                child: _gridView(),
              )
            ],
          ),
        ),
        drawer: CustomDrawer());
  }

  Widget _gridView() => Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      children: getCards(),
    ),
  );

  Widget _dashboardCard(String title, String news) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 0),
        child: Card(
          elevation: 10,
          shadowColor: AppColors.primaryColorOp01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () {
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(news,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w800)),
                  ),
                  Divider(thickness: 2,),
                  Text(title,
                      style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 120.0,
                      height: 120.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> getCards() {
    print("*********************");
    List<Widget> cardWidgets = [];
    for(int i=0; i<news.length; i++){
      cardWidgets.add(_dashboardCard(news[i].name ?? "", news[i].type ?? ""));
    }
    return cardWidgets;
  }
}
