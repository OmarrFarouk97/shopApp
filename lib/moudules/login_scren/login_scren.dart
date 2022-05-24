import 'package:flutter/material.dart';

import '../../compomats/shared_componat/componat.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'Email  must  not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    suffix: isPasswordShow ?Icons.remove_red_eye:Icons.visibility_off,
                    isPassword: isPasswordShow,
                    controller: passwordController,
                    prefix: Icons.lock,
                    type: TextInputType.visiblePassword,
                    suffixPressed: (){
                      setState(() {
                        isPasswordShow =!isPasswordShow;
                      });
                    },
                    label: 'Password',
                    validator: (value)
                    {
                      if (value.isEmpty)
                        {
                          return 'Password must  not be empty';
                        }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   controller: passwordController,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   obscureText: true,
                  //   onFieldSubmitted: (String value) {
                  //     print(value);
                  //   },
                  //   onChanged: (String value) {
                  //     print(value);
                  //   },
                  //   validator: (  value)
                  //   {
                  //     if (value!.isEmpty){
                  //       return 'Password  must not be emtpy';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     prefixIcon: Icon(
                  //       Icons.lock,
                  //     ),
                  //     suffixIcon: Icon(
                  //       Icons.remove_red_eye,
                  //     ),
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'ReGister',
                    radius: 10,
                    function: () {
                      if(formKey.currentState!.validate())
                        {
                          print(emailController.text);
                          print(passwordController.text);
                        }

                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                      text:
                      'Login',
                      function: ()
                      {

                      }
                      ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
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
  }
}
