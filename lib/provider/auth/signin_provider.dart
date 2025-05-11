import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../view/screens/home_screen.dart';

class SignInProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  sign(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((onValue) {
            isLoading = false;
            notifyListeners();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ERROR OCCURRED $e')));
    }
  }
}
