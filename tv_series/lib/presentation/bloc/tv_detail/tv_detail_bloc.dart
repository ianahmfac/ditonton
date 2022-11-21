import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  TvDetailBloc(
    this.getTvDetail,
  ) : super(TvDetailInitial()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (fail) => emit(TvDetailError(fail.message)),
        (data) => emit(TvDetailLoaded(data)),
      );
    });
  }
}
