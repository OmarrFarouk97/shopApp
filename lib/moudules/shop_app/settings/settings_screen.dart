import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/compomats/shared_componat/constan.dart';
import 'package:project_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:project_udemy/layout/shop_app/cubit/states.dart';

class SettingsScreen extends StatelessWidget
{
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state)
      {
        if (state is ShopSuccessUserDataState)
          {

            nameController.text = state.loginModel.data!.name!;
            emailController.text = state.loginModel.data!.email!;
            phoneController.text = state.loginModel.data!.phone!;
          }
      },
      builder: (context,state)
      {
        var model =ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                SizedBox(height: 20,),
                
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null ;
                    },
                    label: 'name',
                    prefix: Icons.person
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'email must not be empty';
                      }
                      return null ;
                    },
                    label: 'email',
                    prefix: Icons.email
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null ;
                    },
                    label: 'phone',
                    prefix: Icons.phone
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                    text: 'Update',
                    function: ()
                    {
                      ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                      );
                    }
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                    text: 'Logout',
                    function: ()
                    {
                      signOut(context);
                    }
                ),

              ],
            ),
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
