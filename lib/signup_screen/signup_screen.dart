import 'package:flutter/material.dart';
import 'package:shop_app/login_screen/login_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var emailFormController = TextEditingController();
    var passwordFormController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SIGNUP',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('SignUp now to enjoy our offers',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 30.0,),
                defaultFormField(
                  controller: emailFormController,
                  type: TextInputType.emailAddress,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'Please enter your email';
                    }
                  },
                  label: 'E-Mail',
                  prefix: Icons.email_outlined,
                ),
                SizedBox(height: 25.0,),
                defaultFormField(
                  isPassword: true,
                  controller: passwordFormController,
                  type: TextInputType.text,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'Please enter your Password';
                    }
                  },
                  label: 'Password',
                  prefix: Icons.lock_outline,
                  suffix: Icons.visibility,
                  suffixPressed: (){},
                ),
                SizedBox(height: 20,),
                defaultButton(
                  function: (){},
                  text: 'signup'.toUpperCase(),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?',
                      style: TextStyle(color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                    defaultTExtButton(
                      fontSize: 15,
                      text: 'signin',
                      onPressed: (){
                         navigateTo(context, LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
