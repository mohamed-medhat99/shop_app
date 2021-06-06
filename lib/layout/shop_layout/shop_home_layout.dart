import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/login_screen/login_screen.dart';
import 'package:shop_app/search/search.dart';
import 'package:shop_app/shared/components.dart';

import 'package:shop_app/shared/network/local/chace_helper.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit , HomePageStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = HomePageCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Awfar'),
            actions: [
              IconButton( icon:Icon(Icons.search) , onPressed: (){
                navigateTo(context, SearchScreen());
              }, ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {cubit.ChangeIndex(index);
            },
            elevation: 0.0,
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home) , title: Text('Home')),
              BottomNavigationBarItem(icon: Icon(Icons.apps) , title: Text('Catrgories')),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline) , title: Text('Favourites')),
              BottomNavigationBarItem(icon: Icon(Icons.settings) , title: Text('Settings')),
            ],
          ),
        );
      },
    );
  }
}
