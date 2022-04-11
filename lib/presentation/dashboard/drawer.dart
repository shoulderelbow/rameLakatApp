import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/common/shared_prefs.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppAssets.doctorImagePng, "Doctors", () {Navigator.of(context).pushNamed('/doctors');}),
          _listItem(
              AppAssets.myAppointmentIconPng, AppStrings.diseasesLabel,
                  () {
                Navigator.of(context).pushNamed('/diseases');
              }),
          _listItem(
              AppAssets.newAppointmentsIconPng, AppStrings.medicalInstitutionsLabel,
                  () {
                    Navigator.of(context).pushNamed('/institutions');
              }),
          _listItem(
              AppAssets.medicalRecordsIconPng, AppStrings.medicalRecordsLabel,
                  () {
              }),
          _listItem(AppAssets.statisticsIconPng, AppStrings.statisticsLabel, () {
          }),
          _listItem(
              AppAssets.accountSettingsIconPng, AppStrings.MyProfile,
                  () {
              }),
          _listItem(AppAssets.helpIconPng, AppStrings.helpLabel, () {}),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppAssets.logoutIconPng, AppStrings.logoutLabel, () {})
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
                child: AppAssets.profileImagePng,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
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
                  children:  [
                    Text(
                      '${SharedPrefs().getUser().firstName} ${SharedPrefs().getUser().lastName}',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      SharedPrefs().getUser().email,
                      style: const TextStyle(
                          color: AppColors.darkTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
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
            Container(child: imageAsset, height: 22, alignment: Alignment.center,),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.commonTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}