import 'dart:convert';

import 'package:news_c13_friday/cache_helper.dart';
import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';
import 'package:news_c13_friday/repository/repo.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class HomeRemoteImpl implements HomeRepo {
  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    Uri url = Uri.https(Constant.BASE_URL, "/v2/everything", {
      "apiKey": Constant.API_KEY,
      "sources": sourceId,
    });
    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);
    await HiveService.saveNewsResponse(newsResponse);
    print("NewsResponse saved");
    return newsResponse;
  }

  @override
  Future<SourcesResponse> getSources(String catId) async {
    Uri url = Uri.https(Constant.BASE_URL, "/v2/top-headlines/sources",
        {"apiKey": Constant.API_KEY, "category": catId});
    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    await HiveService.saveSourceResponse(sourcesResponse);
    print("SourcesResponse saved");
    return sourcesResponse;
  }
}
