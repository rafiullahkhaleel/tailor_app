import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndividualScreenProvider extends ChangeNotifier{
  List<DocumentSnapshot> _snapshot = [];
  String? _error;
  bool _isLoading = false;

 List<DocumentSnapshot> get snapshot => _snapshot;
 String? get error=> _error;
 bool get isLoading => _isLoading;

  Future<void> fetchData()async{
    _isLoading = true;
    _error = null;
    notifyListeners();
    try{
      await FirebaseFirestore.instance.collection('individual').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((data){
        _isLoading = false;
        _error = null;
        notifyListeners();
        _snapshot = data.docs;

      });

    }catch(e){
      _error = e.toString();
      print(e.toString());
      _isLoading = false;
    }
    notifyListeners();
  }
}