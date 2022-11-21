part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tvDetail;

  TvDetailLoaded(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
