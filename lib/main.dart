import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/layout/shop_layout/shop_home_layout.dart';
import 'package:shop_app/login_screen/login_screen.dart';
import 'package:shop_app/on_borarding_screen/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/chace_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/themes.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer=MyBlocObserver();
  await ChaceHelper.init();
  Widget widget;
  bool onBoarding = ChaceHelper.getData(key: 'onBoarding');
  token = ChaceHelper.getData(key: 'token');
  print(token);
  if(onBoarding != null)
    {
      if(token != null)widget = ShopLayout();
      else widget  = LoginScreen();
    }else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider(
         create: (BuildContext context)=>HomePageCubit()..getHomeData()..getCategoriesData()..getFavorites(),
       )
     ],
      child: BlocConsumer<HomePageCubit , HomePageStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home:startWidget,
          );
        },
      ),
    );
  }
}


