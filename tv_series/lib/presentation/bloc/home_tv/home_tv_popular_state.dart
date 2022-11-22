part of 'home_tv_popular_bloc.dart';

abstract class HomeTvPopularState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTvPopularInitial extends HomeTvPopularState {}

class HomeTvPopularLoading extends HomeTvPopularState {}

class HomeTvPopularLoaded extends HomeTvPopularState {
  final List<TvSeries> popularTv;
  HomeTvPopularLoaded({
    required this.popularTv,
  });
  @override
  List<Object?> get props => [popularTv];
}

class HomeTvPopularError extends HomeTvPopularState {
  final String message;
  HomeTvPopularError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
