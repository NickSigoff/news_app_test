import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/news_model.dart';

class SharedPreferencesService {
  final String _latestNewsKey = 'latestNews';

  Future<bool> setLatestNewsSharedPreferences(News news) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        _latestNewsKey, jsonEncode(news.toJson()));
  }

  Future<String?> getLatestNewsSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_latestNewsKey);
  }
}
