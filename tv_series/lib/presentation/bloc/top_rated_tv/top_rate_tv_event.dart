part of 'top_rate_tv_bloc.dart';

abstract class TopRatedTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTopRatedTvEvent extends TopRatedTvEvent {
  final bool isLoadMore;
  GetTopRatedTvEvent({
    this.isLoadMore = false,
  });

  @override
  List<Object?> get props => [isLoadMore];
}
