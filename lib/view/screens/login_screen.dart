import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/login_provider.dart';
import 'package:tailor_app/view/screens/signup_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: provider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              CustomField(
                controller: provider.emailController,
                hint: 'Email',
                emptyFieldError: 'Please enter Email',
              ),
              CustomField(
                controller: provider.passwordController,
                hint: 'Password',
                emptyFieldError: 'Please enter Password',
                lengthError: 'At least 6 characters are required',
              ),
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return CustomButton(
                    onTap: () {
                      if (provider.formKey.currentState!.validate()) {
                        provider.sign(context);
                      }
                    },
                    title: 'Log In',
                    isLoading: provider.isLoading,
                  );
                },
              ),
              RichText(
                text: TextSpan(
                  text: "Don't have an account ? ",
                  style: TextStyle(color: Colors.black87,fontSize: 17),
                  children: [
                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: provider.tapGestureRecognizer .. onTap = (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>SignupScreen()));
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
