import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool obscure = false;
  LoginBloc() : super(LoginInitial()) {
    on<LoginClicked>(loginClicked);
    on<ObscureEvent>((event, emit) {
      obscure = !obscure;
      emit(ObscuredState(obscure: obscure));
    });
  }

  Future<void> loginClicked(
    LoginClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(Loginloading());
    
  }
}
