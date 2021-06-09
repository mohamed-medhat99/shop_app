import 'package:shop_app/models/change_favorites/change_favorites.dart';

abstract class HomePageStates{}

class HomePageInitialState extends HomePageStates{}

class HomePageChangeIndexState extends HomePageStates{}

class HomePageLoadingState extends HomePageStates{}
class HomePageSuccessState extends HomePageStates{}
class HomePageIErrorState extends HomePageStates{
  final String error;

  HomePageIErrorState(this.error);

}

class CategoriesSuccessState extends HomePageStates{}
class CategoriesErrorState extends HomePageStates{
  final String error;

  CategoriesErrorState(this.error);
}

class ChangeFavoritesSuccessState extends HomePageStates{
  final ChangeFavorites model ;

  ChangeFavoritesSuccessState(this.model);
}

class ChangeFSuccessState extends HomePageStates{}

class ChangeFavoritesErrorState extends HomePageStates {
  final String error;

  ChangeFavoritesErrorState(this.error);

}