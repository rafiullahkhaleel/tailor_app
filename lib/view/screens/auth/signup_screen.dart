import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/auth/signin_provider.dart';
import 'package:tailor_app/view/screens/auth/login_screen.dart';
import 'package:tailor_app/view/widgets/custom_button.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  @override
  void dispose() {
    tapGestureRecognizer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
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
              Consumer<SignInProvider>(
                builder: (context, provider, child) {
                  return CustomButton(
                    onTap: () {
                      if (provider.formKey.currentState!.validate()) {
                        provider.sign(context);
                      }
                    },
                    title: 'Sign Up',
                    isLoading: provider.isLoading,
                  );
                },
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account ? ',
                  style: TextStyle(color: Colors.black87,fontSize: 17),
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: tapGestureRecognizer .. onTap = (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>LoginScreen()));
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
