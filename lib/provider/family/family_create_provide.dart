import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/family_create_model.dart';
import 'package:tailor_app/view/screens/family/family_record_screen.dart';
import 'package:tailor_app/view/screens/home_screen.dart';

class FamilyCreateProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  bool get isLoading => _isLoading;
  get formKey => _formKey;

  Future<void> saveFamily(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('families').doc();
      final newData = FamilyCreateModel(
        headName: nameController.text,
        phoneNo: phoneController.text,
        id: documentReference.id,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      await documentReference.set(newData.toMap()).then((value) {
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(tabIndex: 1)),
        );
        _nameController.clear();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ERROR OCCURRED $e')));
    }
  }
}
