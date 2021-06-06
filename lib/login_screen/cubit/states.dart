import 'package:shop_app/models/login%20models/user_login.dart';

abstract class LoginStates {}

class ShopInitialState extends LoginStates{}
class ShopLoginLoadingState extends LoginStates{}
class ShopLoginSuccessState extends LoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends LoginStates
{

  final String error;
ShopLoginErrorState(this.error);
}
class ShopShowPasswordState extends LoginStates{}
