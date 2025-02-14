import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c13_friday/api_manager.dart';
import 'package:news_c13_friday/bloc/cubit.dart';
import 'package:news_c13_friday/bloc/states.dart';
import 'package:news_c13_friday/news_item.dart';

class NewsWidget extends StatelessWidget {
  NewsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetNewsDataLoadingState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is GetNewsDataErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(state.error),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<HomeCubit>(context);
        var list = bloc.newsResponse?.articles ?? [];
        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 25,
          ),
          itemBuilder: (context, index) {
            return NewsItem(article: list[index]);
          },
          itemCount: list.length ?? 0,
        );
      },
    );
  }
}
