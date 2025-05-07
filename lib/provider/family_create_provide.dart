import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/view/screens/family_record_screen.dart';
import 'package:tailor_app/view/screens/home_screen.dart';

class FamilyCreateProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  final  _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController get controller => _controller;
  bool get isLoading => _isLoading;
    get formKey => _formKey;

  Future<void> saveFamily(BuildContext context)async{
    try{
      _isLoading = true;
      notifyListeners();
      String docsName = DateTime.now().microsecondsSinceEpoch.toString();
      await FirebaseFirestore.instance.collection('families').doc(docsName).set(
          {
            'headName' : controller.text,
            'id' : docsName,
            'uid' : FirebaseAuth.instance.currentUser!.uid
          }).then((value){
            _isLoading = false;
            notifyListeners();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>HomeScreen(tabIndex: 1,)));
            _controller.clear();
      });
    }catch(e){
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ERROR OCCURRED $e')));
    }
  }
}