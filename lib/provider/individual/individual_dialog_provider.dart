import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/model/individual_model.dart';
import '../../view/screens/home_screen.dart';

class IndividualDialogProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController sleeveController = TextEditingController();
  TextEditingController neckbandController = TextEditingController();
  TextEditingController backYokeController = TextEditingController();
  TextEditingController pantsHeightController = TextEditingController();
  TextEditingController painaController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  void clear() {
    nameController.clear();
    heightController.clear();
    widthController.clear();
    sleeveController.clear();
    neckbandController.clear();
    backYokeController.clear();
    pantsHeightController.clear();
    painaController.clear();
    addressController.clear();
    phoneController.clear();
  }

  notify() {
     notifyListeners();
   }

  Future<void> saveData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final newData = IndividualModel(
      id: '',
      name: nameController.text,
      height: heightController.text,
      width: widthController.text,
      sleeve: sleeveController.text,
      neckband: neckbandController.text,
      backYoke: backYokeController.text,
      pantsHeight: pantsHeightController.text,
      paina: painaController.text,
      uid: FirebaseAuth.instance.currentUser!.uid,
      address : addressController.text,
      phoneNo : phoneController.text,
    );

    try {
      await FirebaseFirestore.instance
          .collection('individual')
          .doc(DateTime.now().microsecondsSinceEpoch.toString())
          .set(newData.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully Saved')),
      );
      clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(tabIndex: 0)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
      Navigator.of(context).pop();
    }

    isLoading = false;
    notifyListeners();
  }
}
