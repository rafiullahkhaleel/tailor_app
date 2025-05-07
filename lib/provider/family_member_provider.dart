import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyMemberProvider extends ChangeNotifier{
  List<DocumentSnapshot> _snapshot = [];
  String? _error;
  bool _isLoading = false;

  List<DocumentSnapshot> get snapshot => _snapshot;
  String? get error=> _error;
  bool get isLoading => _isLoading;

  Future<void> fetchData(String id)async{
    _isLoading = true;
    _error = null;
    notifyListeners();
    try{
      await FirebaseFirestore.instance.collection('familyMembers').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((data){
        _isLoading = false;
        _error = null;
        notifyListeners();
        final allDocs = data.docs;
        _snapshot = allDocs.where((doc){
          return doc['id'] == id;
        }).toList();

      });

    }catch(e){
      _error = e.toString();
      print(e.toString());
      _isLoading = false;
    }
    notifyListeners();
  }
}