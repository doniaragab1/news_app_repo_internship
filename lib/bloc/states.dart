abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class GetSourcesLoadingState extends HomeStates {}

class GetSourcesSuccessState extends HomeStates {}

class GetSourcesErrorState extends HomeStates {
  String error;

  GetSourcesErrorState(this.error);
}

class GetNewsDataLoadingState extends HomeStates {}

class GetNewsDataSuccessState extends HomeStates {}

class GetNewsDataErrorState extends HomeStates {
  String error;

  GetNewsDataErrorState(this.error);
}

class ChangeSelectedTabState extends HomeStates {}
