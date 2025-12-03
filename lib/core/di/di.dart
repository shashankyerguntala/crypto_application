import 'package:final_l3/core/constants/api_constants.dart';
import 'package:final_l3/data/data_sources/local_data_sources/auth_local_data_source.dart';
import 'package:final_l3/data/data_sources/remote_data_sources/crypto_remote_data_source.dart';
import 'package:final_l3/data/repo_impl/auth_repo_impl.dart';
import 'package:final_l3/data/repo_impl/crypto_repo_impl.dart';
import 'package:final_l3/domain/repository/auth_repository.dart';
import 'package:final_l3/domain/usecase/auth_usecase.dart';
import 'package:final_l3/domain/usecase/crypto_usecase.dart';
import 'package:final_l3/presentation/features/register/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:final_l3/core/router/app_router.dart';
import 'package:final_l3/core/network/dio_client.dart';

import 'package:final_l3/domain/repository/crypto_repository.dart';

import 'package:final_l3/presentation/features/login/bloc/login_bloc.dart';
import 'package:final_l3/presentation/features/dashboard/bloc/dashboard_bloc.dart';

class Di {
  static final GetIt di = GetIt.instance;

  static Future<void> init() async {
    di.registerLazySingleton<AppRouter>(() => AppRouter());
    di.registerLazySingleton(() => DioClient(baseUrl: ApiConstants.baseUrl));

    //! data source
    di.registerLazySingleton<CryptoRemoteDataSource>(
      () => CryptoRemoteDataSourceImpl(di<DioClient>()),
    );

    di.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
    //! repository
    di.registerLazySingleton<CryptoRepository>(
      () => CryptoRepositoryImpl(di<CryptoRemoteDataSource>()),
    );
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(di<AuthLocalDataSource>()),
    );
    //! usecase
    di.registerLazySingleton<CryptoUsecase>(
      () => CryptoUsecase(di<CryptoRepository>()),
    );

    di.registerLazySingleton<AuthUsecase>(
      () => AuthUsecase(repo: di<AuthRepository>()),
    );

    //! bloc

    di.registerFactory<LoginBloc>(() => LoginBloc(di<AuthUsecase>()));
    di.registerFactory<RegisterBloc>(() => RegisterBloc(di<AuthUsecase>()));
    di.registerFactory<DashboardBloc>(() => DashboardBloc(di<CryptoUsecase>()));
  }
}
