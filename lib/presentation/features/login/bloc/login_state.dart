part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class Loginloading extends LoginState {}

final class LoginError extends LoginState {
  final String msg;
  LoginError({required this.msg});
}

final class LoginSuccess extends LoginState {
  final String msg;
  LoginSuccess({required this.msg});
}

final class ObscuredState extends LoginState {
  final bool obscure;
  ObscuredState({required this.obscure});
}
