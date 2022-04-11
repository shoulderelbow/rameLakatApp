import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rame_lakat_app/bussines_logic/services/authentication/user_auth.dart';
import 'package:rame_lakat_app/bussines_logic/services/common/shared_prefs.dart';
import 'package:rame_lakat_app/presentation/login/login_state.dart';
import 'package:rame_lakat_app/presentation/login/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailTextChanged>(_emailTextChanged);
    on<PasswordTextChanged>(_passwordTextChanged);
    on<LoginButtonPressed>(_loginButtonPushed);
  }

  Future<void> _emailTextChanged(
      EmailTextChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _passwordTextChanged(
      PasswordTextChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _loginButtonPushed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    UserAuth userAuthService = UserAuth(firebaseAuth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
    var user = await userAuthService.signInWithCredentials(event.email, event.password);
    SharedPrefs().setUser(user);
  }
}
