part of 'popular_tv_bloc.dart';

abstract class PopularTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPopularTvEvent extends PopularTvEvent {
  final bool isLoadMore;
  GetPopularTvEvent({
    this.isLoadMore = false,
  });

  @override
  List<Object?> get props => [isLoadMore];
}
