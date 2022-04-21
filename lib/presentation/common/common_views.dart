import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';

import 'app_styles.dart';

ElevatedButton elevatedButton(
        {required String text,
        required Color color,
        required Function onPress,
        Color textColor = Colors.white,
        double textSize = 18,
        FontWeight fontWeight = FontWeight.w500,
        bool compactSize = false}) =>
    ElevatedButton(
        onPressed: () => {onPress.call()},
        child: Text(
          text,
          style: TextStyle(
              fontSize: textSize, color: textColor, fontWeight: fontWeight),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: compactSize ? 0 : 14)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))));

Widget toolbarView(String label) => Container(
    height: 60.0,
    padding: const EdgeInsets.only(left: 15, bottom: 10),
    alignment: Alignment.centerLeft,
    child: Text(label,
        style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 22,
            fontWeight: FontWeight.w600)),
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            offset: const Offset(0, 1.0),
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ]));

Widget searchTextField() {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    elevation: 5,
    shadowColor: AppColors.primaryColorOp01,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: _textField(),
    ),
  );
}

TextField _textField() => TextField(
    autofocus: false,
    style: const TextStyle(color: AppColors.commonTextColor, fontSize: 18),
    decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffixIcon: Icon(
          Icons.search_outlined,
          color: Colors.black.withOpacity(0.3),
        ),
        contentPadding:
            const EdgeInsets.only(left: 5, bottom: 16, top: 16, right: 15),
        hintStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.3)),
        hintText: AppStrings.searchText));

PreferredSizeWidget appBar(GlobalKey<ScaffoldState> globalKey, BuildContext context) =>
    AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: AppAssets.drawerIconPng,
        //onPressed: () => {},
        onPressed: () => globalKey.currentState?.openDrawer(),
      ),
      actions: <Widget>[
        IconButton(
          icon: AppAssets.profileIconPng,
          onPressed: () => {
            Navigator.of(context).pushNamed('/doctor_details'),
          },
          //onPressed: () => {context.navigateToScreen(MyProfile())},
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );

Widget appbarWithBack(BuildContext context,
    {bool isProfileIconEnabled = true}) {
  return AppBar(
    backgroundColor: AppColors.backGroundColor,
    elevation: 0,
    leading: IconButton(
      icon:  Icon(
        Icons.arrow_back_ios,
        color: AppColors.primaryDark,
      ),
      onPressed: () => {Navigator.pop(context)},
    ),
    actions: <Widget>[
      isProfileIconEnabled
          ? IconButton(
              icon: AppAssets.profileIconPng,
              onPressed: () => {},
              //onPressed: () => {context.navigateToScreen(MyProfile())},
            )
          : Container(),
      SizedBox(
        width: isProfileIconEnabled ? 8 : 0,
      ),
    ],
  );
}

Widget textField(String hint, IconData iconData,
        TextEditingController textEditingController,
        {bool isReadonly = false, required Function onTap, int minLines = 1}) =>
    Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
          autofocus: false,
          onTap: () {
            onTap.call();
          },
          minLines: minLines,
          maxLines: null,
          controller: textEditingController,
          showCursor: !isReadonly,
          readOnly: isReadonly,
          style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: IconButton(
                icon: Icon(
                  iconData,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {},
              ),
              contentPadding: EdgeInsets.only(
                  left: 10, bottom: 12, top: 12, right: 10),
              hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5)),
              hintText: hint)),
    );

class userContainer extends StatelessWidget {

  String nekistring = '';
  userContainer(this.nekistring);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(child: Text(nekistring, style: userText(),)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        height: 60,
        width: 80,
      ),
    );
  }
}

