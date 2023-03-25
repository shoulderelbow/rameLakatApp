import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_styles.dart';
import 'package:rame_lakat_app/presentation/dashboard/my_profile_widget.dart';
import '../../bussines_logic/services/common/shared_prefs.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/User.dart';
import '../../data/models/parameter.dart';
import '../common/common_views.dart';
import 'dashboard_screen.dart';

List<User> users = [];

class MyProfile extends StatefulWidget {
  MyProfile({Key? key,required this.parameter}) : super(key: key);
  final Parameter parameter;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  late User user;

  Future<void> getUser(String id) async {
    user = await FirebaseApi.getUser(id);
  }

  Future<void> getUsers() async {
    users = await FirebaseApi.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: FutureBuilder(
          future: getUser(SharedPrefs().getUser().uniqueId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      value: 50,
                    ));
              case ConnectionState.done:
                return MyProfileWidget(user: user);
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


