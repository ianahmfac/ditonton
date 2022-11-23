part of 'top_rate_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRateTvInitial extends TopRatedTvState {}

class TopRateTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<TvSeries> tvSeries;
  TopRatedTvLoaded({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;
  TopRatedTvError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class TopRatedTvLoadMore extends TopRatedTvState {}
