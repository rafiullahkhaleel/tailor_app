import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            'id' : docsName
          }).then((value){
            _isLoading = false;
            notifyListeners();
            Navigator.of(context).pop();
            _controller.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: Text('SUCCESSFULLY SAVED'),
                ));
      });
    }catch(e){
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ERROR OCCURRED $e')));
    }
  }
}