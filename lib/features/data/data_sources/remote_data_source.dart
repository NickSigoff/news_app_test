import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

//https://api.nytimes.com/svc/topstories/v2/us.json?api-key=T5A7fKOwG8KT0080HOqplvmyGgxMrEch
class RemoteDataSource {
  Future<News> getSectionArticles(String section) async {
    var uri = Uri.parse(
        'https://api.nytimes.com/svc/topstories/v2/$section.json?api-key=T5A7fKOwG8KT0080HOqplvmyGgxMrEch');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception('Something is wrong. Status code ${response.statusCode}');
    }
  }
}
