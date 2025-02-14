import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';

abstract class HomeRepo {
  Future<SourcesResponse> getSources(String catId);

  Future<NewsResponse> getNewsData(String sourceId);
}
