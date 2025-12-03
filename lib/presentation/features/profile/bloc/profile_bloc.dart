import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/domain/usecase/hive_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final HiveUseCase hiveUseCase;

  ProfileBloc(this.hiveUseCase) : super(ProfileInitial()) {
    on<LoadProfile>(loadProfile);
    on<LogoutEvent>(logoutEvent);
  }

  Future<void> loadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final email = hiveUseCase.getCurrentUser();

    if (email == null || email.isEmpty) {
      emit(ProfileError(msg: StringConstants.failedToFetchUser));
      return;
    }

    emit(ProfileLoaded(email: email));
  }

  Future<void> logoutEvent(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    await hiveUseCase.clearCurrentUser();

    emit(ProfileLoggedOut(msg: StringConstants.logoutSuccess));
  }
}
