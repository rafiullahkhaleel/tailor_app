import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/firebase_options.dart';
import 'package:tailor_app/provider/individual_dialog_provider.dart';
import 'package:tailor_app/provider/login_provider.dart';
import 'package:tailor_app/provider/signin_provider.dart';
import 'package:tailor_app/view/screens/home_screen.dart';
import 'package:tailor_app/view/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => SignInProvider()),
        ChangeNotifierProvider(create: (create) => LoginProvider()),
        ChangeNotifierProvider(create: (create) => IndividualDialogProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: user != null ? HomeScreen() : const SignupScreen(),
      ),
    );
  }
}
