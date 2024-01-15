part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {
  var visible;
  NewsInitial(this.visible);
}

class NewsLoadedState extends NewsState {
  final List<dynamic> news;
  var visible;

  NewsLoadedState(this.news,this.visible);
}

class NewsErrorState extends NewsState {
  final String errorMessage;

  NewsErrorState(this.errorMessage);
}

