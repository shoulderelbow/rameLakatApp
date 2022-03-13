import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authetication_event.dart';
part 'authetication_state.dart';

class AutheticationBloc extends Bloc<AutheticationEvent, AutheticationState> {
  AutheticationBloc() : super(AutheticationInitial()) {
    on<AutheticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
