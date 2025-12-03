import 'package:bloc/bloc.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/domain/usecase/auth_usecase.dart';
import 'package:final_l3/domain/usecase/hive_usecase.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUsecase authUsecase;
  final HiveUseCase hiveUseCase;
  bool isObscure = true;

  RegisterBloc({required this.authUsecase, required this.hiveUseCase})
    : super(RegisterInitial()) {
    on<RegisterClicked>(onRegisterClicked);
    on<TogglePass>(onTogglePass);
  }

  Future<void> onRegisterClicked(
    RegisterClicked event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final result = await authUsecase.register(event.email, event.password);

    if (result.isLeft()) {
      final fail = result.fold((err) => err, (user) => null);
      emit(RegisterError(msg: fail!.msg));
      return;
    }

    final user = result.fold((l) => null, (user) => user)!;

    await hiveUseCase.setCurrentUser(user.email);

    emit(RegisterSuccess(msg: '${user.email} ${StringConstants.registered}'));
  }

  void onTogglePass(TogglePass event, Emitter<RegisterState> emit) {
    isObscure = !isObscure;
    emit(Obscured(obscure: isObscure));
  }
}
