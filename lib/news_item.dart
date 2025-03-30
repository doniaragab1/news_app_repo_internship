import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c13_friday/model/news_response.dart';

class NewsItem extends StatelessWidget {
  Articles article;

  NewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Color(0xFF171717))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                article.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Byyyy : ${article.author?.split(" ").first}"),
                  Text(article.publishedAt?.substring(0, 10) ?? "")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
