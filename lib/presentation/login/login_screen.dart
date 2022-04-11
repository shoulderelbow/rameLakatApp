import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rame_lakat_app/presentation/common/app_assets.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';
import 'package:rame_lakat_app/presentation/common/app_strings.dart';
import 'package:rame_lakat_app/presentation/common/common_views.dart';
import 'package:rame_lakat_app/presentation/login/login_bloc.dart';
import 'package:rame_lakat_app/presentation/login/login_state.dart';
import 'package:rame_lakat_app/presentation/login/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                const LogoWidget(),
                const LoginTitleWidget(),
                const WelcomeTextWidget(),
                EmailInputField(emailController: _emailController),
                PasswordInputField(passwordController: _passwordController),
                const LoginButton(),
                const RegistrationButton(),
              ],
            ),
          ),
        ));
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
          onChanged: (email) {
            context.read<LoginBloc>().add(EmailTextChanged(email: email));
          },
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
              hintText: AppStrings.email),
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
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
                context
                    .read<LoginBloc>()
                    .add(PasswordTextChanged(password: password));
              },
              autofocus: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: passwordController,
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
      },
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
          text: "Sign-in",
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          onPress: () async {
            context.read<LoginBloc>().add(
                  LoginButtonPressed(
                      email: context.read<LoginBloc>().state.email,
                      password: context.read<LoginBloc>().state.password),
                );
            Navigator.of(context).pushNamed('/dashboard');
          }),
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
          text: "Sign-up",
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
        children: const [
          Text("Welcome",
              style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          Text("Please sign-in to continue",
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
