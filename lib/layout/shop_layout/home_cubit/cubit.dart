import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/categories/categories.dart';
import 'package:shop_app/favourites/favourites_screen.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/products/products.dart';
import 'package:shop_app/settings/settings.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomePageCubit extends Cubit<HomePageStates>{
  HomePageCubit() : super (HomePageInitialState());
  
  static HomePageCubit  get(context) =>BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> screens =[
  ProductsScreen(),
  CategoriesScreen(),
  FavouritesScreen(),
  SettingsScreen(),
  ];
   void ChangeIndex(int index){
     currentIndex = index;
     emit(HomePageChangeIndexState());
   }

   HomeModel homeModel;

   void getHomeData(){
     emit(HomePageLoadingState());
     DioHelper.getData(
         url: HOME,
         token: token,
     ).then((value)  {
       homeModel = HomeModel.fromJson(value.data);
       print(homeModel.data.banners.toString());
       print(homeModel.status);
     emit(HomePageSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(HomePageIErrorState(error));
     });
   }


   CategoriesModel categoriesModel;
   void getCategoriesData()
   {
     DioHelper.getData(
      url: GET_CATEGORIES,
     ).then((value) {
       categoriesModel = CategoriesModel.fromJson(value.data);
       print('categories data status = ${categoriesModel.status}');
       emit(CategoriesSuccessState());
     }).catchError((error){
       print('categories error message = ${error.toString()}');
     });
   }
}