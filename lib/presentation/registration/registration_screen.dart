import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FirebaseApi fApi = FirebaseApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _logo(),
                _title(),
                _welcomeText(),
                EmailInputField(emailController: _emailController),
                FirstNameInputField(firstNameController: _firstNameController),
                LastNameInputField(lastNameController: _lastNameController),
                PasswordInputField(passwordController: _passwordController),
                _registerButton(),
              ],
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
          ]),
        ));
  }

  Widget _welcomeText() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
        child: Column(
          children: const [
            Text("Enter email and password",
                style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
            Text("To make an account",
                style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400))
          ],
        ));
  }

  Widget _registerButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: elevatedButton(
            text: "Create account",
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            onPress: () async {
              try {
                final data = await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
                await FirebaseApi.addUser(
                    userEmail: _emailController.text,
                    dateCreated: DateTime.now(),
                    userPassword: _passwordController.text,
                    userFirstName: _firstNameController.text,
                    userLastName: _lastNameController.text,
                    userId: data.user?.uid);
                Navigator.of(context).pop();
              } catch (e) {
                print(e);
              }
            }),
        margin: const EdgeInsets.symmetric(vertical: 20));
  }
}

class FirstNameInputField extends StatelessWidget {
  const FirstNameInputField({Key? key, required this.firstNameController})
      : super(key: key);

  final TextEditingController firstNameController;

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
          autofocus: false,
          keyboardType: TextInputType.text,
          controller: firstNameController,
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
              hintText: "First name"),
        ),
      ),
    );
  }
}

class LastNameInputField extends StatelessWidget {
  const LastNameInputField({Key? key, required this.lastNameController})
      : super(key: key);

  final TextEditingController lastNameController;

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
          autofocus: false,
          keyboardType: TextInputType.text,
          controller: lastNameController,
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
              hintText: "Last name"),
        ),
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key, required this.emailController})
      : super(key: key);

  final TextEditingController emailController;

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
          autofocus: false,
          keyboardType: TextInputType.text,
          controller: emailController,
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
              hintText: "E-mail"),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key, required this.passwordController})
      : super(key: key);

  final TextEditingController passwordController;

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
          autofocus: false,
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: passwordController,
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
              hintText: "Password"),
        ),
      ),
    );
  }
}
