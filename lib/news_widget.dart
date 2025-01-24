import 'package:flutter/material.dart';
import 'package:news_c13_friday/api_manager.dart';
import 'package:news_c13_friday/news_item.dart';

class NewsWidget extends StatelessWidget {
  String sourceId;

  NewsWidget({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getNews(sourceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        if(snapshot.data!.articles!.isEmpty){
          return Center(child: Text("No Data"));
        }
        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 25,
          ),
          itemBuilder: (context, index) {
            return NewsItem(article: snapshot.data!.articles![index]);
          },
          itemCount: snapshot.data?.articles?.length ?? 0,
        );
      },
    );
  }
}
