import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyMemberDialogProvider extends ChangeNotifier{
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

  Future<void> familyMemberData(BuildContext context,String id) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('familyMembers')
          .doc(DateTime.now().microsecondsSinceEpoch.toString())
          .set({
        'name': nameController.text,
        'relation' : relationController.text,
        'height': heightController.text,
        'width': widthController.text,
        'sleeve': sleeveController.text,
        'neckband': neckbandController.text,
        'backYoke': backYokeController.text,
        'pantsHeight': pantsHeightController.text,
        'paina': painaController.text,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'id' : id
      })
          .then((val) {
        isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text('SUCCESSFULLY SAVED'),
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
      Navigator.of(context).pop();
    }
  }
}