import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:final_l3/domain/usecase/auth_usecase.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUsecase authUsecase;
  bool obscure = true;

  LoginBloc(this.authUsecase) : super(LoginInitial()) {
    on<LoginClicked>(loginClicked);
    on<ObscureEvent>(toggleObscure);
  }

  Future<void> loginClicked(
    LoginClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(Loginloading());

    final result = await authUsecase.login(event.email, event.pass);

    result.fold(
      (fail) => emit(LoginError(msg: fail.msg)),
      (user) => emit(LoginSuccess(msg: "Welcome ${user.email}")),
    );
  }

  void toggleObscure(ObscureEvent event, Emitter<LoginState> emit) {
    obscure = !obscure;
    emit(ObscuredState(obscure: obscure));
  }
}
