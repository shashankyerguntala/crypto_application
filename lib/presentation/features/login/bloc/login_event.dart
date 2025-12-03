part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginClicked extends LoginEvent {
  final String email;
  final String pass;

  LoginClicked({required this.email, required this.pass});
}

final class ObscureEvent extends LoginEvent {}
