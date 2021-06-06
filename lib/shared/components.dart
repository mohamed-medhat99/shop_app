import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/login_screen/login_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/network/local/chace_helper.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


void navigateTo (context , widget){

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateToAndRemove (context , widget){

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
      (route){
      return false;
      }
  );
}
Widget defaultTExtButton({
   double fontSize,
  @required String text,
  @required Function onPressed,
})=>TextButton(
  child: Text(text.toUpperCase(),
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
    ),
  ),
  onPressed: onPressed,
);

void showToast ({
  @required String msg,
  @required toastState state,
})=>Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: changeToastState(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum toastState{SUCCESS , ERROR ,WARNING}

Color changeToastState (toastState state){
  Color color;
  switch(state)
  {
    case(toastState.SUCCESS):
      color=Colors.green;
      break;

    case(toastState.ERROR):
      color= Colors.red;
      break;

    case(toastState.WARNING):
      color= Colors.amber;
      break;
  }
  return color;
}

void signOut (context) =>ChaceHelper.clearToken(
  key:'token',
).then((value){
  if(value)
  {
    navigateToAndRemove(context, LoginScreen());
  }
});
String token = '';