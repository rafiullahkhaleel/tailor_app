import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyMemberProvider extends ChangeNotifier {
  TextEditingController filteredController = TextEditingController();
  List<DocumentSnapshot> _snapshot = [];
  List<DocumentSnapshot> _filteredSnapshot = [];
  String? _error;
  bool _isLoading = false;

  List<DocumentSnapshot> get snapshot => _snapshot;
  List<DocumentSnapshot> get filteredSnapshot => _filteredSnapshot;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchData(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      print('doc id is $id');
      await FirebaseFirestore.instance
          .collection('families')
          .doc(id)
          .collection('familyMembers')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((data) {
            print('Member data');
            _isLoading = false;
            _error = null;
            notifyListeners();
            final allDocs = data.docs;

            _snapshot = allDocs;
          });
    } catch (e) {
      _error = e.toString();
      print(e.toString());
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> delete(String firstId, String id) async {
    await FirebaseFirestore.instance
        .collection('families')
        .doc(firstId)
        .collection('familyMembers')
        .doc(id)
        .delete();
    _snapshot.removeWhere((doc) => doc.id == id);
    _filteredSnapshot.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  void filter(String search) {
    _filteredSnapshot =
        snapshot.where((docs) {
          return docs['name'].toString().toLowerCase().contains(
            search.toLowerCase(),
          );
        }).toList();
    notifyListeners();
  }
}
