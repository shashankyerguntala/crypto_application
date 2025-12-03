part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String email;

  const ProfileLoaded({required this.email});
  @override
  List<Object> get props => [email];
}

final class ProfileError extends ProfileState {
  final String msg;

  const ProfileError({required this.msg});

  @override
  List<Object> get props => [msg];
}

final class ProfileLoggedOut extends ProfileState {
  final String msg;

  const ProfileLoggedOut({required this.msg});

  @override
  List<Object> get props => [msg];
}
