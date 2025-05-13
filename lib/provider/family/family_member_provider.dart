import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/family_members_model.dart';

class FamilyMemberProvider extends ChangeNotifier {
  TextEditingController filteredController = TextEditingController();
  List<FamilyMembersModel> _snapshot = [];
  List<FamilyMembersModel> _filteredSnapshot = [];
  String? _error;
  bool _isLoading = false;

  List<FamilyMembersModel> get snapshot => _snapshot;
  List<FamilyMembersModel> get filteredSnapshot => _filteredSnapshot;
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


            _snapshot = data.docs.map((docs){
              return FamilyMembersModel.fromMap(docs.data());
            }).toList();
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
          return docs.name.toString().toLowerCase().contains(
            search.toLowerCase(),
          );
        }).toList();
    notifyListeners();
  }
}
