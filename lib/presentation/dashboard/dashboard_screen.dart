import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';

import 'drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        key: _scaffoldKey,
        appBar: appBar(_scaffoldKey, context),
        body: SafeArea(
          child: Column(
            children: [
              toolbarView(AppStrings.dashboardLabel),
              Container(
                child: searchTextField(),
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              ),
              Expanded(
                child: _gridView(),
              )
            ],
          ),
        ),
        drawer: const CustomDrawer());
  }

  Widget _gridView() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      children: [
        _dashboardCard(AppStrings.appointmentsCardLabel,
            AppAssets.appointmentsCardBgPng, const LoginScreen()),
        _dashboardCard(AppStrings.recordsCardLabel,
            AppAssets.recordsCardBgPng, const LoginScreen()),
        _dashboardCard(AppStrings.forumCardLabel, AppAssets.forumCardBgPng,
            const LoginScreen()),
        _dashboardCard(AppStrings.MyProfile,
            AppAssets.accountSettingsCardBgPng, const LoginScreen())
      ],
    ),
  );

  Widget _dashboardCard(String title, Widget image, StatefulWidget screen) {
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
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 120.0,
                      height: 120.0,
                      child: image,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
