import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c13_friday/api_manager.dart';
import 'package:news_c13_friday/bloc/cubit.dart';
import 'package:news_c13_friday/bloc/states.dart';
import 'package:news_c13_friday/model/sources_response.dart';
import 'package:news_c13_friday/news_widget.dart';
import 'package:news_c13_friday/repository/repo_local_impl.dart';
import 'package:news_c13_friday/repository/repo_remote_impl.dart';

class TabsSection extends StatelessWidget {
  String categoryName;
  Function onTap;

  TabsSection({super.key, required this.categoryName, required this.onTap});

  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(hasInternet ? HomeRemoteImpl() : HomeLocalImpl())
            ..getSources(categoryName),
      child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is GetSourcesLoadingState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is GetSourcesErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(state.error),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      onTap();
                    },
                    child: Text("Go TO Home"))
              ],
            ),
          );
        }
      }, builder: (context, state) {
        var bloc = BlocProvider.of<HomeCubit>(context);
        var sources = bloc.sourcesResponse?.sources ?? [];

        return DefaultTabController(
          length: sources.length ?? 0,
          initialIndex: bloc.selectedIndex,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  onTap: (value) {
                    bloc.changeSelectedTab(value);
                  },
                  dividerColor: Colors.transparent,
                  indicatorColor: Color(0xFF171717),
                  labelColor: Color(0xFF171717),
                  tabs: sources
                      .map((source) => Tab(
                            text: source.name,
                          ))
                      .toList()),
              Expanded(
                child: NewsWidget(),
              )
            ],
          ),
        );
      }),
    );
  }
}
