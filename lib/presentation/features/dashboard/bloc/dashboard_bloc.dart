import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_l3/domain/usecase/crypto_usecase.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final CryptoUsecase cryptoUsecase;

  DashboardBloc(this.cryptoUsecase) : super(DashboardInitial()) {
    on<LoadDashboardData>(onLoad);
    on<RefreshDashboardData>(onRefresh);
  }

  Future<void> onLoad(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final result = await cryptoUsecase();

    result.fold(
      (failure) => emit(DashboardError(failure.msg)),
      (coins) => emit(DashboardLoaded(coins)),
    );
  }

  Future<void> onRefresh(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    final result = await cryptoUsecase();

    result.fold(
      (failure) => emit(DashboardError(failure.msg)),
      (coins) => emit(DashboardLoaded(coins)),
    );
  }
}
