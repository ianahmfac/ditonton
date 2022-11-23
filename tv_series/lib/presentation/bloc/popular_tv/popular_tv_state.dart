part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<TvSeries> tvSeries;
  PopularTvLoaded({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class PopularTvError extends PopularTvState {
  final String message;
  PopularTvError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class PopularTvLoadMore extends PopularTvState {}
