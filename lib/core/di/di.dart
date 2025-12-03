import 'package:final_l3/core/constants/api_constants.dart';
import 'package:final_l3/data/data_sources/local_data_sources/auth_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/cached_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/favourite_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/settings_local_data_source.dart';
import 'package:final_l3/data/data_sources/remote_data_sources/crypto_remote_data_source.dart';
import 'package:final_l3/data/repo_impl/auth_repo_impl.dart';
import 'package:final_l3/data/repo_impl/crypto_repo_impl.dart';
import 'package:final_l3/data/repo_impl/hive_repo_impl.dart';
import 'package:final_l3/domain/repository/auth_repository.dart';
import 'package:final_l3/domain/repository/hive_repository.dart';
import 'package:final_l3/domain/usecase/auth_usecase.dart';
import 'package:final_l3/domain/usecase/crypto_usecase.dart';
import 'package:final_l3/domain/usecase/hive_usecase.dart';
import 'package:final_l3/presentation/features/coin_details/bloc/coin_details_bloc.dart';
import 'package:final_l3/presentation/features/favourites/bloc/favourites_bloc.dart';
import 'package:final_l3/presentation/features/profile/bloc/profile_bloc.dart';
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
    di.registerLazySingleton<CacheLocalDataSource>(
      () => CacheLocalDataSource(),
    );
    di.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
    di.registerLazySingleton<FavouriteLocalDataSource>(
      () => FavouriteLocalDataSource(),
    );
    di.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSource(),
    );
    //! repository
    di.registerLazySingleton<CryptoRepository>(
      () => CryptoRepositoryImpl(di<CryptoRemoteDataSource>()),
    );
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(di<AuthLocalDataSource>()),
    );
    di.registerLazySingleton<HiveRepository>(
      () => HiveRepositoryImpl(
        auth: di<AuthLocalDataSource>(),
        favourites: di<FavouriteLocalDataSource>(),
        cache: di<CacheLocalDataSource>(),
        settings: di<SettingsLocalDataSource>(),
      ),
    );
    //! usecase
    di.registerLazySingleton<CryptoUsecase>(
      () => CryptoUsecase(di<CryptoRepository>()),
    );

    di.registerLazySingleton<AuthUsecase>(
      () => AuthUsecase(repo: di<AuthRepository>()),
    );
    di.registerLazySingleton<HiveUseCase>(
      () => HiveUseCase(di<HiveRepository>()),
    );
    //! bloc

    di.registerFactory<LoginBloc>(() => LoginBloc(di<AuthUsecase>()));
    di.registerFactory<RegisterBloc>(
      () => RegisterBloc(
        authUsecase: di<AuthUsecase>(),
        hiveUseCase: di<HiveUseCase>(),
      ),
    );
    di.registerFactory<DashboardBloc>(() => DashboardBloc(di<CryptoUsecase>()));
    di.registerFactory<CoinDetailsBloc>(
      () => CoinDetailsBloc(di<HiveUseCase>()),
    );
    di.registerFactory<ProfileBloc>(() => ProfileBloc(di<HiveUseCase>()));
    di.registerFactory<FavouritesBloc>(() => FavouritesBloc(di<HiveUseCase>()));
  }
}
