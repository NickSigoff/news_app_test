part of 'news_page_content_bloc.dart';

@immutable
abstract class NewsPageContentEvent {}

class OnCreatePageEvent extends NewsPageContentEvent {
  final String sectionName;

  OnCreatePageEvent({required this.sectionName});
}

class NewsUpdateEvent extends NewsPageContentEvent {
  final String sectionName;
  final News news;

  NewsUpdateEvent({required this.sectionName, required this.news});
}

class OnSearchArticleEvent extends NewsPageContentEvent {
  final String sectionName;
  final String searchedString;

  OnSearchArticleEvent(
      {required this.searchedString, required this.sectionName});
}
