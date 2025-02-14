import 'package:hive/hive.dart';
import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';

class HiveService {
  static const String sourcesBox = "SourcesBox1";
  static const String newsBox = "NewsBox1";

  static Future<Box<SourcesResponse>> _openBox() async {
    if (!Hive.isBoxOpen(sourcesBox)) {
      return await Hive.openBox<SourcesResponse>(sourcesBox);
    }

    return Hive.box<SourcesResponse>(sourcesBox);
  }

  static Future<void> saveSourceResponse(SourcesResponse source) async {
    var box = await _openBox();

    await box.put("sourceResponse", source);
  }

  static Future<SourcesResponse> getSourceResponse() async {
    var box = await _openBox();

    SourcesResponse? sourceResponse = box.get("sourceResponse");
    return sourceResponse ?? SourcesResponse();
  }

  static Future<void> deleteSourceResponse() async {
    var box = await _openBox();
    box.delete("sourceResponse");
  }

  static Future<Box<NewsResponse>> _openNewsBox() async {
    if (!Hive.isBoxOpen(newsBox)) {
      return await Hive.openBox<NewsResponse>(newsBox);
    }

    return Hive.box<NewsResponse>(newsBox);
  }

  static Future<void> saveNewsResponse(NewsResponse news) async {
    var box = await _openNewsBox();

    await box.put("newsResponse", news);
  }

  static Future<NewsResponse> getNewsResponse() async {
    var box = await _openNewsBox();

    NewsResponse? newsResponse = box.get("newsResponse");
    return newsResponse ?? NewsResponse();
  }

  static Future<void> deleteNewsResponse() async {
    var box = await _openNewsBox();
    box.delete("newsResponse");
  }
}
