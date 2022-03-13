part of 'authetication_bloc.dart';

abstract class AutheticationState extends Equatable {
  const AutheticationState();
}

class AutheticationInitial extends AutheticationState {
  @override
  List<Object> get props => [];
}
