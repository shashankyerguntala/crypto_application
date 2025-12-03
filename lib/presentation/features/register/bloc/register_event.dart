part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterClicked extends RegisterEvent {
  final String email;
  final String password;

  RegisterClicked({required this.email, required this.password});
}

final class TogglePass extends RegisterEvent {}
