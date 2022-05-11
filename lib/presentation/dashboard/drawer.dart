import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/common/shared_prefs.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';

import '../../bussines_logic/services/authentication/user_auth.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var language;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppAssets.accountSettingsIconPng, AppStrings.MyProfile.tr(), () {
            Navigator.of(context).pushNamed('/my_profile');
          }),
          _listItem(AppAssets.diseases, AppStrings.diseasesLabel.tr(), () {
            Navigator.of(context).pushNamed('/diseases');
          }),
          _listItem(AppAssets.medicalInstitutions, AppStrings.medicalInstitutionsLabel.tr(), () {
            Navigator.of(context).pushNamed('/institutions');
          }),
          _listItem(AppAssets.simposiumImagePng, AppStrings.simposiumLabel.tr(), () {
            Navigator.of(context).pushNamed('/simposiums');
          }),
          _listItem(AppAssets.podcastIconPng, AppStrings.podcastLabel.tr(), () {
            Navigator.of(context).pushNamed('/podcasts_and_materials');
          }),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    language = context.locale.languageCode;
                    if (language == 'sr') {
                      setState(() {
                        context.setLocale(Locale('en'));
                      });
                    }
                  });
                },
                child: Container(
                    child: Image.asset(
                  "images/usaflag.png",
                  height: 30,
                  width: 30,
                )),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    language = context.locale.languageCode;
                    if (language == 'en') {
                      setState(() {
                        context.setLocale(Locale('sr'));
                      });
                    }
                  });
                },
                child: Container(
                    child: Image.asset(
                  "images/serbiaflag.png",
                  height: 32,
                  width: 32,
                )),
              ),
            ],
          ),
          _listItem(AppAssets.logoutIconPng, AppStrings.logoutLabel.tr(), () async {
            UserAuth userAuthService = UserAuth(firebaseAuth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
            await userAuthService.signOut();
            SharedPrefs().removeUser();
            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          })
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 75.0,
                height: 75.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://idsb.tmgrup.com.tr/ly/uploads/images/2021/09/08/thumbs/800x531/142774.jpg"),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${SharedPrefs().getUser().firstName} ${SharedPrefs().getUser().lastName}',
                      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      SharedPrefs().getUser().email,
                      style: const TextStyle(color: AppColors.darkTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      decoration: const BoxDecoration(
          color: AppColors.backGroundColor,
      ),
    );
  }

  Widget _listItem(Widget imageAsset, String title, Function() onPress) {
    return TextButton(
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: imageAsset,
              height: 22,
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.commonTextColor, fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
