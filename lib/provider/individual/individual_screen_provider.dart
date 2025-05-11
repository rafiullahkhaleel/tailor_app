import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/individual_model.dart';

class IndividualScreenProvider extends ChangeNotifier {
  TextEditingController filterController = TextEditingController();
  List<IndividualModel> _allList = [];
  List<IndividualModel> _filteredList = [];
  String? _error;
  bool _isLoading = false;

  List<IndividualModel> get allList => _allList;
  List<IndividualModel> get filteredList => _filteredList;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('individual')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      _allList = snapshot.docs
          .map((doc) => IndividualModel.fromMap(doc.data(), doc.id))
          .toList();

      _filteredList = _allList;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('individual').doc(id).delete();
    _allList.removeWhere((item) => item.id == id);
    _filteredList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void filter(String query) {
    _filteredList = _allList
        .where((item) =>
        item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class IndividualScreenProvider extends ChangeNotifier {
//   TextEditingController filterController = TextEditingController();
//   List<DocumentSnapshot> _snapshot = [];
//   List<DocumentSnapshot> _filteredSnapshot = [];
//   String? _error;
//   bool _isLoading = false;
//
//   List<DocumentSnapshot> get snapshot => _snapshot;
//   List<DocumentSnapshot> get filteredSnapshot => _filteredSnapshot;
//
//   String? get error => _error;
//   bool get isLoading => _isLoading;
//
//   Future<void> fetchData() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       await FirebaseFirestore.instance
//           .collection('individual')
//           .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get()
//           .then((data) {
//             _isLoading = false;
//             _error = null;
//             notifyListeners();
//             _snapshot = data.docs;
//           });
//     } catch (e) {
//       _error = e.toString();
//       _isLoading = false;
//     }
//     notifyListeners();
//   }
//   Future<void> delete(String id)async{
//
//     await FirebaseFirestore.instance
//         .collection('individual')
//         .doc(id)
//         .delete();
//     _snapshot.removeWhere((doc) => doc.id == id);
//     _filteredSnapshot.removeWhere((doc) => doc.id == id);
//     notifyListeners();
//   }
//   void filter(String search) {
//     _filteredSnapshot =
//         _snapshot.where((docs) {
//           return docs['name'].toString().toLowerCase().contains(
//             search.toLowerCase(),
//           );
//         }).toList();
//     notifyListeners();
//   }
// }
