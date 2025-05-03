import 'package:flutter/material.dart';

class IndividualDialogProvider extends ChangeNotifier{
  TextEditingController nameController = TextEditingController();

  notify(){
    notifyListeners();
  }
}