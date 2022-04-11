
abstract class LoginEvent {}

class EmailTextChanged extends LoginEvent {
  EmailTextChanged({required this.email});

  final String email;
}

class PasswordTextChanged extends LoginEvent {
  PasswordTextChanged({required this.password});

  final String password;
}

class LoginButtonPressed extends LoginEvent{
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}
