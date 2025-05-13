import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/family_members_model.dart';
import 'package:tailor_app/view/screens/family/family_members_screen.dart';

class FamilyMemberDialogProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController sleeveController = TextEditingController();
  TextEditingController neckbandController = TextEditingController();
  TextEditingController backYokeController = TextEditingController();
  TextEditingController pantsHeightController = TextEditingController();
  TextEditingController painaController = TextEditingController();
  bool isLoading = false;

  clear() {
    relationController.clear();
    nameController.clear();
    heightController.clear();
    widthController.clear();
    sleeveController.clear();
    neckbandController.clear();
    backYokeController.clear();
    pantsHeightController.clear();
    painaController.clear();
  }

  notify() {
    notifyListeners();
  }

  Future<void> familyMemberData(
    BuildContext context,
    String id,
    String title,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      DocumentReference reference =
          FirebaseFirestore.instance
              .collection('families')
              .doc(id)
              .collection('familyMembers')
              .doc();

      final newData = FamilyMembersModel(
          name: nameController.text,
          relation: relationController.text,
          height: heightController.text,
          width: widthController.text,
          sleeve: sleeveController.text,
          neckband: neckbandController.text,
          backYoke: backYokeController.text,
          pantsHeight: pantsHeightController.text,
          paina: painaController.text,
          uid: FirebaseAuth.instance.currentUser!.uid,
          id: reference.id);

      await reference.set(newData.toMap())
          .then((val) {
            isLoading = false;
            clear();
            notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blueGrey,
                content: Text('SUCCESSFULLY SAVED'),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FamilyMembersScreen(title: title, id: id),
              ),
            );
          });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('ERROR OCCURRED $e'),
        ),
      );
    }
  }
}
