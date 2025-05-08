import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndividualScreenProvider extends ChangeNotifier {
  TextEditingController filterController = TextEditingController();
  List<DocumentSnapshot> _snapshot = [];
  List<DocumentSnapshot> _filteredSnapshot = [];
  String? _error;
  bool _isLoading = false;

  List<DocumentSnapshot> get snapshot => _snapshot;
  List<DocumentSnapshot> get filteredSnapshot => _filteredSnapshot;

  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection('individual')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((data) {
            _isLoading = false;
            _error = null;
            notifyListeners();
            _snapshot = data.docs;
          });
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  void filter(String search) {
    _filteredSnapshot =
        _snapshot.where((docs) {
          return docs['name'].toString().toLowerCase().contains(
            search.toLowerCase(),
          );
        }).toList();
    notifyListeners();
  }
}
