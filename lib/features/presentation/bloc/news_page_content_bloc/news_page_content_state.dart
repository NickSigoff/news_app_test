part of 'news_page_content_bloc.dart';

@immutable
abstract class NewsPageContentState {}

class NewsPageContentInitial extends NewsPageContentState {}

class NewsPageContentSuccess extends NewsPageContentState {
  final News news;

  NewsPageContentSuccess({required this.news});
}

class NewsPageContentLocalSuccess extends NewsPageContentState {
  final News news;

  NewsPageContentLocalSuccess({required this.news});
}

class NewsPageContentLoading extends NewsPageContentState {}

class NewsPageContentError extends NewsPageContentState {
  final String errorMessage;

  NewsPageContentError({required this.errorMessage});
}
