import 'package:final_l3/core/constants/api_constants.dart';
import 'package:final_l3/data/data_sources/remote_data_sources/crypto_remote_data_source.dart';
import 'package:final_l3/data/repo_impl/crypto_repo_impl.dart';
import 'package:final_l3/domain/usecase/crypto_usecase.dart';
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
    di.registerLazySingleton<CryptoRemoteDataSource>(
      () => CryptoRemoteDataSourceImpl(di<DioClient>()),
    );

    di.registerLazySingleton<CryptoRepository>(
      () => CryptoRepositoryImpl(di<CryptoRemoteDataSource>()),
    );

    di.registerLazySingleton<CryptoUsecase>(
      () => CryptoUsecase(di<CryptoRepository>()),
    );

    di.registerFactory<LoginBloc>(() => LoginBloc());

    di.registerFactory<DashboardBloc>(() => DashboardBloc(di<CryptoUsecase>()));
  }
}
