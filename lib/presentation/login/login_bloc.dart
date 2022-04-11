import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rame_lakat_app/presentation/login/login_state.dart';
import 'package:rame_lakat_app/presentation/login/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailTextChanged>(_emailTextChanged);
    on<PasswordTextChanged>(_passwordTextChanged);
  }

  Future<void> _emailTextChanged(
      EmailTextChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _passwordTextChanged(
      PasswordTextChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.password));
  }

  Future<void> _loginButtonPushed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
  }
}
