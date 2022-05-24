import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/compomats/shared_componat/constan.dart';
import 'package:project_udemy/layout/shop_app/shop_layout.dart';
import 'package:project_udemy/moudules/shop_app/login/cubit/cubit.dart';
import 'package:project_udemy/moudules/shop_app/login/cubit/states.dart';
import 'package:project_udemy/network/local/shared_preferences.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if  (state is ShopLoginSuccessState )
          {
            if(state.loginModel.status!)
              {
                print(state.loginModel.message);
                print(state.loginModel.data!.token);
                showToast(
                    text: state.loginModel.message,
                    state: ToastStates.SUCCESS
                );
                CacheHelper.saveData(
                     key: 'token',
                     value: state.loginModel.data!.token
                ).then((value) {
                   navigateAndFinish(context, ShopLayout());
                   token = state.loginModel.data!.token;
                 });
              }
            else
                {
                  print(state.loginModel.message);
                  showToast(
                    text: state.loginModel.message,
                    state: ToastStates.ERROR
                  );
                }
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height:30.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: ( value)
                          {
                            if(value.isEmpty)
                            {
                              return 'email must not empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();

                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>  defaultButton(
                            text: 'login',
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }

                            },
                            isUpperCase: true,
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextBottom(
                              function: ()
                              {
                                navigateTo(context, ShopRegisterScreen(),);
                              },
                              text: 'register',
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
        ),
      );
  }
}
