import 'package:flutter/material.dart';
import 'package:test_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
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
              key: formKey, //used with validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                // it won't work here because of SingleChildScrollView widget has infinite height
                children: [
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      label: 'Email',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Email address must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      label: 'Password',
                      prefix: Icons.lock,
                      suffix: isPasswordShow
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isPassword: isPasswordShow,
                      suffixPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                      type: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Login',
                    function: () {
                      if (formKey.currentState.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'ReGIster',
                    function: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            print('Hello TextButton');
                          },
                          child: Text('Register Now')),
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
