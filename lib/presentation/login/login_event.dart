
abstract class LoginEvent {}

class EmailTextChanged extends LoginEvent {
  EmailTextChanged({required this.email});

  final String email;
}

class PasswordTextChanged extends LoginEvent {
  PasswordTextChanged({required this.password});

  final String password;
}

class LoginButtonPressed extends LoginEvent{}
