import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/family_create_model.dart';

class FamilyRecordProvider extends ChangeNotifier {
  TextEditingController filterController = TextEditingController();
  List<FamilyCreateModel> _snapshot = [];
  List<FamilyCreateModel> _filteredSnapshot = [];
  bool _isLoading = false;
  String? _error;

  List<FamilyCreateModel> get snapshot => _snapshot;
  List<FamilyCreateModel> get filteredSnapshot => _filteredSnapshot;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data =
          await FirebaseFirestore.instance
              .collection('families')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
      _snapshot = data.docs.map((docs){
        return FamilyCreateModel.fromMap(docs.data());
      }).toList();
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // This method now deletes familyMembers before deleting family
  Future<void> delete(String id) async {
    try {
      // Step 1: Get all familyMembers under this family
      final familyMembersSnapshot =
          await FirebaseFirestore.instance
              .collection('families')
              .doc(id)
              .collection('familyMembers')
              .get();

      // Step 2: Delete all familyMembers
      for (var doc in familyMembersSnapshot.docs) {
        await doc.reference.delete();
      }

      // Step 3: Delete the family document
      await FirebaseFirestore.instance.collection('families').doc(id).delete();

      // Step 4: Remove from local list
      _snapshot.removeWhere((doc) => doc.id == id);
      _filteredSnapshot.removeWhere((doc) => doc.id == id);

      notifyListeners();
    } catch (e) {
      _error = "Error deleting family: ${e.toString()}";
      notifyListeners();
    }
  }

  void filter(String search) {
    _filteredSnapshot =
        snapshot.where((docs) {
          return docs.headName.toString().toLowerCase().contains(
            search.toLowerCase(),
          );
        }).toList();
    notifyListeners();
  }
}
