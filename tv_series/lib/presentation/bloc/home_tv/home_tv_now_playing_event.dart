part of 'home_tv_now_playing_bloc.dart';

abstract class HomeTvNowPlayingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetHomeNowPlayingTv extends HomeTvNowPlayingEvent {}
