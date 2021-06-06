import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/login_screen/cubit/states.dart';
import 'package:shop_app/models/login%20models/user_login.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPressed = true;

  void showPassword(){
    isPressed =! isPressed;
    suffix = isPressed ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopShowPasswordState());
  }

}
