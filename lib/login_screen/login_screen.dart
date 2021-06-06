import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_home_layout.dart';
import 'package:shop_app/login_screen/cubit/cubit.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/chace_helper.dart';
import 'package:shop_app/signup_screen/signup_screen.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if(state is ShopLoginSuccessState)
            {
            if(state.loginModel.status)
            {
              ChaceHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
              ).then((value){
                showToast(msg: state.loginModel.message, state:toastState.SUCCESS);
                navigateToAndRemove(context, ShopLayout()
                );
              });
            }
            else
              {
                showToast(msg: state.loginModel.message,
                  state: toastState.ERROR,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'login now to enjoy our offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                            },
                            label: 'E-Mail',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                            isPassword: LoginCubit.get(context).isPressed,
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              }
                            },
                            onSubmit: (value){
                              if (formKey.currentState.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: (){
                              LoginCubit.get(context).showPassword();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t Have An Account?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              defaultTExtButton(
                                fontSize: 15,
                                text: 'signup',
                                onPressed: () {
                                  navigateTo(context, SignupScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
