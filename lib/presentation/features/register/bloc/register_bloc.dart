import 'package:bloc/bloc.dart';
import 'package:final_l3/domain/usecase/auth_usecase.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUsecase usecase;
  bool isObscure = true;

  RegisterBloc(this.usecase) : super(RegisterInitial()) {
    on<RegisterClicked>(onRegisterClicked);
    on<TogglePass>(onTogglePass);
  }

  Future<void> onRegisterClicked(
    RegisterClicked event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final result = await usecase.register(event.email, event.password);

    result.fold(
      (fail) => emit(RegisterError(msg: fail.msg)),
      (user) => emit(RegisterSuccess(msg: '${user.email} Registered')),
    );
  }

  void onTogglePass(TogglePass event, Emitter<RegisterState> emit) {
    isObscure = !isObscure;
    emit(Obscured(obscure: isObscure));
  }
}
