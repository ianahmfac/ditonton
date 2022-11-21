part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;
  GetTvDetailEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
