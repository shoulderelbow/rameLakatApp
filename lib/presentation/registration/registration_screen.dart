import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../login/login_screen.dart';

String globalFirstName = '';
String globalLastName = '';
String globalEmail = '';
String globalPassword = '';
String globalConfirmPassword = '';
String globalUsername = '';
String dateYear = "";
String dateMonth = "";
String dateDay = '';


class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseApi fApi = FirebaseApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Stack(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Align(alignment: Alignment.topLeft),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _logo(),
                      _title(),
                      _welcomeText(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(width: 50, child: FirstNameInputField()),
                          ),
                          Expanded(
                            child: Container(width: 50, child: LastNameInputField()),
                          ),
                        ],
                      ),
                      UsernameInputField(),
                      dateTimePicker(),
                      EmailInputField(),
                      PasswordInputField(),
                      ConfirmPasswordInputField(),
                      _registerButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _logo() {
    return SizedBox(
      child: AppAssets.blueHeartPng,
      width: 70.0,
    );
  }

  Widget _title() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(children: [
            TextSpan(
              text: AppStrings.appNamePart1,
              style: TextStyle(color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: AppStrings.appNamePart2,
              style: TextStyle(color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.w300),
            ),
          ]),
        ));
  }

  Widget _welcomeText() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
        child: Column(
          children: [
            Text(
              "enterFields".tr(),
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              "makeAccount".tr(),
              style: TextStyle(color: AppColors.darkTextColor, fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ));
  }

  Widget _registerButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: elevatedButton(
            text: "Create account".tr(),
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            onPress: () async {
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(globalEmail);
              if (globalEmail == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyEmail".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalPassword == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyPassword".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalFirstName == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyFirstName".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalLastName == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyLastName".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalUsername == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyUsername".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalConfirmPassword == "") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emptyConfirmPassword".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (emailValid == false) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("emailFormatIncorrect".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else if (globalPassword != globalConfirmPassword) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'.tr()),
                    content: Text("incorrectConfirmPassword".tr()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Back".tr()),
                      ),
                    ],
                  ),
                );
              } else {
                try {
                  final data = await _auth.createUserWithEmailAndPassword(
                    email: globalEmail,
                    password: globalPassword,
                  );
                  await FirebaseApi.addUser(
                    userEmail: globalEmail,
                    dateCreated: DateTime.now(),
                    userPassword: globalPassword,
                    userFirstName: globalFirstName,
                    userLastName: globalLastName,
                    userName: globalUsername,
                    userId: data.user?.uid,
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                }
              }
            }),
        margin: const EdgeInsets.symmetric(vertical: 20));
  }
}

class FirstNameInputField extends StatelessWidget {
  const FirstNameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (firstName) {
            globalFirstName = firstName;
          },
          autofocus: false,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "FirstName".tr()),
        ),
      ),
    );
  }
}

class dateTimePicker extends StatefulWidget {
  const dateTimePicker({Key? key}) : super(key: key);

  @override
  State<dateTimePicker> createState() => _dateTimePickerState();
}

class _dateTimePickerState extends State<dateTimePicker> {

  @override
  Widget build(BuildContext context) {
    return
      Card(
        elevation: 3,
        shadowColor: AppColors.primaryColorOp01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            child: Container(
              height: 52,
              width: 400,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: dateDay == "" ? Text("Date of birth".tr(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),) : Text("${dateDay}.${dateMonth}.${dateYear}" , style: TextStyle(color: AppColors.primaryColor, fontSize: 18),),
                  ),
                  Expanded(
                    child: Container(
                      width: 6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_today_outlined, color: Colors.black.withOpacity(0.2)),
                  ),
                ],
              ),
            ),
            onTap: (){
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1920, 1, 1),
                    maxTime: DateTime(2022, 12, 31),
                    theme: DatePickerTheme(
                        headerColor: AppColors.darkTextColor,
                        backgroundColor: AppColors.lightBlueColor,
                        itemStyle: TextStyle(color: Colors.black, fontSize: 18),
                        cancelStyle: TextStyle(color: Colors.white, fontSize: 18),
                        doneStyle: TextStyle(color: Colors.white, fontSize: 16)), onChanged: (date) {
                    }, onConfirm: (date) {
                      dateYear = date.year.toString();
                      dateMonth = date.month.toString();
                      dateDay = date.day.toString();
                      setState(() {

                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
            ),
          ));
  }
}

class LastNameInputField extends StatelessWidget {
  const LastNameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (lastName) {
            globalLastName = lastName;
          },
          autofocus: false,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "LastName".tr()),
        ),
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (email) {
            globalEmail = email;
          },
          autofocus: false,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "E-mail".tr()),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (password) {
            globalPassword = password;
          },
          autofocus: false,
          obscureText: true,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "Password".tr()),
        ),
      ),
    );
  }
}

class ConfirmPasswordInputField extends StatelessWidget {
  const ConfirmPasswordInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (confirmPassword) {
            globalConfirmPassword = confirmPassword;
          },
          autofocus: false,
          obscureText: true,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "ConfirmPassword".tr()),
        ),
      ),
    );
  }
}

class UsernameInputField extends StatelessWidget {
  const UsernameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          onChanged: (username) {
            globalUsername = username;
          },
          autofocus: false,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.2)),
              hintText: "Username".tr()),
        ),
      ),
    );
  }
}
