import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyMemberProvider extends ChangeNotifier{
  TextEditingController filteredController = TextEditingController();
  List<DocumentSnapshot> _snapshot = [];
  List<DocumentSnapshot> _filteredSnapshot = [];
  String? _error;
  bool _isLoading = false;

  List<DocumentSnapshot> get snapshot => _snapshot;
  List<DocumentSnapshot> get filteredSnapshot => _filteredSnapshot;
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

  Future<void> delete(String id)async{

    await FirebaseFirestore.instance
        .collection('individual')
        .doc(id)
        .delete();
    _snapshot.removeWhere((doc) => doc.id == id);
    _filteredSnapshot.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  void filter(String search){
    _filteredSnapshot = snapshot.where((docs){
      return docs['name'].toString().toLowerCase().contains(search.toLowerCase());
    }).toList();
    notifyListeners();
  }
}