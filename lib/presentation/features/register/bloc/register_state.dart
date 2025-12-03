part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String msg;

  RegisterSuccess({required this.msg});
}

final class RegisterError extends RegisterState {
  final String msg;

  RegisterError({required this.msg});
}

final class RegisterLoading extends RegisterState {}

final class Obscured extends RegisterState {
  final bool obscure;

  Obscured({required this.obscure});
}
