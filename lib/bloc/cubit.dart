import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:news_c13_friday/bloc/states.dart';
import 'package:news_c13_friday/constants.dart';

import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';
import 'package:news_c13_friday/repository/repo.dart';

class HomeCubit extends Cubit<HomeStates> {
  SourcesResponse? sourcesResponse;
  NewsResponse? newsResponse;
  int selectedIndex = 0;
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitState());

  void changeSelectedTab(int index) async {
    selectedIndex = index;
    await getNewsData();
    emit(ChangeSelectedTabState());
  }

  void getSources(String categoryName) async {
    try {
      emit(GetSourcesLoadingState());

      sourcesResponse = await repo.getSources(categoryName);
      if (sourcesResponse!.status == "ok") {
        await getNewsData();
        emit(GetSourcesSuccessState());
      } else {
        emit(GetSourcesErrorState(sourcesResponse?.message ?? ""));
      }
    } catch (e) {
      emit(GetSourcesErrorState("something went wrong"));
    }
  }

  Future<void> getNewsData() async {
    try {
      emit(GetNewsDataLoadingState());

      newsResponse = await repo
          .getNewsData(sourcesResponse?.sources?[selectedIndex].id ?? "");
      if (newsResponse!.status == "ok") {
        emit(GetNewsDataSuccessState());
      } else {
        emit(GetNewsDataErrorState(newsResponse?.message ?? ""));
      }
    } catch (e) {
      emit(GetNewsDataErrorState("Something went wrong"));
    }
  }
}
