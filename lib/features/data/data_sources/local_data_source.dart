import 'dart:convert';

import 'package:news_app_test/features/data/services/shared_preferences_service.dart';

import '../models/news_model.dart';

class LocalDataSource {
  Future<News> getSectionArticles(String section) async {
    String? latestNews;
    if (section.toLowerCase() == 'home') {
      latestNews =
          await SharedPreferencesService().getLatestNewsSharedPreferences();
    }
    return News.fromJson(json.decode(latestNews ?? ''));
  }
}
