import 'package:final_l3/core/router/app_router.dart';
import 'package:final_l3/presentation/features/login/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

class Di {
  static final GetIt di = GetIt.instance;

  static Future<void> init() async {
    di.registerLazySingleton<AppRouter>(() => AppRouter());
    di.registerFactory(() => LoginBloc());
  }
}
