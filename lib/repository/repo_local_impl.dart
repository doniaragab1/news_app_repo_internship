import 'dart:convert';

import 'package:news_c13_friday/cache_helper.dart';
import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';
import 'package:news_c13_friday/repository/repo.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class HomeLocalImpl implements HomeRepo {
  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    NewsResponse newsResponse = await HiveService.getNewsResponse();
    return newsResponse;
  }

  @override
  Future<SourcesResponse> getSources(String catId) async {
    SourcesResponse sourcesResponse = await HiveService.getSourceResponse();
    return sourcesResponse;
  }
}
