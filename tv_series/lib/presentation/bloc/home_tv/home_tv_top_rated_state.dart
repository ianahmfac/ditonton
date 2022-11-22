part of 'home_tv_top_rated_bloc.dart';

abstract class HomeTvTopRatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTvTopRatedInitial extends HomeTvTopRatedState {}

class HomeTvTopRatedLoading extends HomeTvTopRatedState {}

class HomeTvTopRatedLoaded extends HomeTvTopRatedState {
  final List<TvSeries> topRatedTv;
  HomeTvTopRatedLoaded({
    required this.topRatedTv,
  });

  @override
  List<Object?> get props => [topRatedTv];
}

class HomeTvTopRatedError extends HomeTvTopRatedState {
  final String message;
  HomeTvTopRatedError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
