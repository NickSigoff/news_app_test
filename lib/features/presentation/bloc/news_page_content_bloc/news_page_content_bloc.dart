import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_test/features/data/data_sources/local_data_source.dart';
import 'package:news_app_test/features/data/data_sources/remote_data_source.dart';
import 'package:news_app_test/features/data/services/shared_preferences_service.dart';

import '../../../data/models/news_model.dart';
import '../../../data/models/results_model.dart';

part 'news_page_content_event.dart';

part 'news_page_content_state.dart';

class NewsPageContentBloc
    extends Bloc<NewsPageContentEvent, NewsPageContentState> {
  NewsPageContentBloc() : super(NewsPageContentInitial()) {
    on<OnCreatePageEvent>((event, emit) async {
      try {
        emit(NewsPageContentLoading());
        News news = await RemoteDataSource()
            .getSectionArticles(event.sectionName.toLowerCase());
        if (event.sectionName.toLowerCase() == 'home') {
          SharedPreferencesService().setLatestNewsSharedPreferences(news);
        }
        emit(NewsPageContentSuccess(news: news));
      } catch (e) {
        if (event.sectionName.toLowerCase() == 'home') {
          News news = await LocalDataSource().getSectionArticles('home');
          emit(NewsPageContentLocalSuccess(news: news));
        } else {
          emit(NewsPageContentError(errorMessage: e.toString()));
        }
      }
    });

    on<OnSearchArticleEvent>((event, emit) async {
      try {
        emit(NewsPageContentLoading());
        News news = await RemoteDataSource()
            .getSectionArticles(event.sectionName.toLowerCase());
        List<Results>? allResults = news.results;
        if (allResults != null) {
          List<Results> filteredResults = allResults
              .where((element) => element.title!.contains(event.searchedString))
              .toList();
          news.results = filteredResults;
          news.numResults = filteredResults.length;
        }
        emit(NewsPageContentSuccess(news: news));
      } catch (e) {
        emit(NewsPageContentError(errorMessage: e.toString()));
      }
    });

    on<NewsUpdateEvent>((event, emit) async {
      if (_sectionName != event.sectionName) {
        _sectionName = event.sectionName;
        while (_sectionName == event.sectionName) {
          try {
            News getNews =
                await RemoteDataSource().getSectionArticles(_sectionName);
            if (getNews.results![0].title != event.news.results![0].title) {
              add(OnCreatePageEvent(sectionName: event.sectionName));
            }
          } catch (e) {
            if (event.sectionName.toLowerCase() == 'home') {
              News news = await LocalDataSource().getSectionArticles('home');
              emit(NewsPageContentLocalSuccess(news: news));
            } else {
              emit(NewsPageContentError(errorMessage: e.toString()));
            }
          }
          await Future.delayed(const Duration(seconds: 30));
        }
      }
    });
  }

  String _sectionName = '';
}
