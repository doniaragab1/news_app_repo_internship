import 'package:flutter/material.dart';
import 'package:news_c13_friday/api_manager.dart';
import 'package:news_c13_friday/model/sources_response.dart';
import 'package:news_c13_friday/news_widget.dart';

class TabsSection extends StatefulWidget {
  String categoryName;
   TabsSection({super.key ,required this.categoryName});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponse>(
      future: ApiManager.getSources(widget.categoryName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        var data = snapshot.data?.sources ?? [];
        return DefaultTabController(
          length: data.length,
          initialIndex: selectedIndex,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  onTap: (value) {
                    selectedIndex = value;
                    setState(() {});
                  },
                  dividerColor: Colors.transparent,
                  indicatorColor: Color(0xFF171717),
                  labelColor: Color(0xFF171717),
                  tabs: data
                      .map((source) => Tab(
                            text: source.name,
                          ))
                      .toList()),
              Expanded(
                child: NewsWidget(sourceId: data[selectedIndex].id ?? ""),
              )
            ],
          ),
        );
      },
    );
  }
}
