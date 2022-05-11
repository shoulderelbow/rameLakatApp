import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../bussines_logic/services/authentication/user_auth.dart';
import '../../bussines_logic/services/common/shared_prefs.dart';

String globalPassword = "";
String globalEmail = "";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50,),
                  const LogoWidget(),
                  const LoginTitleWidget(),
                  const WelcomeTextWidget(),
                  EmailInputField(),
                  PasswordInputField(),
                  const LoginButton(),
                  const RegistrationButton(),
                ],
              ),
            ),
          ),
        ));
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primaryColorOp01,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          onChanged: (email) {
            globalEmail = email;
          },
          autofocus: true,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                  left: 15, bottom: 16, top: 16, right: 15),
              hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.2)),
              hintText: AppStrings.email),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Card(
          elevation: 3,
          shadowColor: AppColors.primaryColorOp01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextField(
              onChanged: (password) {
                globalPassword = password;
              },
              autofocus: true,
              obscureText: true,
              style:
                  const TextStyle(color: AppColors.primaryColor, fontSize: 18),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 16, top: 16, right: 15),
                  hintStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withOpacity(0.2)),
                  hintText: AppStrings.password),
            ),
          ),
        );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: elevatedButton(
          text: "Sign-in".tr(),
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          onPress: () async {
            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(globalEmail);

            if(globalEmail == "") {
              showDialog(context: context, builder: (context) =>
                  AlertDialog(
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
            }
            else if(globalPassword == "") {
              showDialog(context: context, builder: (context) =>
                  AlertDialog(
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
            }else if(emailValid == false) {
              showDialog(context: context, builder: (context) =>
                  AlertDialog(
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
            }else {
              UserAuth userAuthService = UserAuth(firebaseAuth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
              var user = await userAuthService.signInWithCredentials(globalEmail, globalPassword);

              if(user.email != ""){
                SharedPrefs().setUser(user);
                Navigator.of(context).pushNamed('/dashboard');
              }else{
                showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      title: Text('Error'.tr()),
                      content: Text("emailOrPasswordIncorrect".tr()),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Back".tr()),
                        ),
                      ],
                    ));
              }
            }
            }
          ),
      margin: const EdgeInsets.symmetric(vertical: 7),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: elevatedButton(
          text: "Sign-up".tr(),
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          onPress: () {
            Navigator.of(context).pushNamed('/registration');
          }),
      margin: const EdgeInsets.symmetric(vertical: 7),
    );
  }
}

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
      child: Column(
        children: [
          Text("welcome".tr(),
              style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          Text("Please sign-in to continue".tr(),
              style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

class LoginTitleWidget extends StatelessWidget {
  const LoginTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          children: [
            TextSpan(
              text: AppStrings.appNamePart1,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: AppStrings.appNamePart2,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}



class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppAssets.blueHeartPng,
      width: 70.0,
    );
  }
}

//globalEmail != null && globalEmail != "" && globalPassword != null && globalPassword != "" && emailValid
