import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyRecordProvider extends ChangeNotifier{
  List<DocumentSnapshot> _snapshot = [];
  bool _isLoading = false;
  String? _error ;
  
  List<DocumentSnapshot> get snapshot => _snapshot;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchData()async{
    _isLoading = true;
    _error = null;
    notifyListeners();
    try{
      final data = await FirebaseFirestore.instance.collection('families').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      _snapshot = data.docs;
      _isLoading = false;
      _error = null;
      notifyListeners();
    }catch(e){
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}