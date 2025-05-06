import 'package:flutter/material.dart';
import 'package:tailor_app/view/widgets/family_create_dialog.dart';

class FamilyRecordScreen extends StatefulWidget {
  const FamilyRecordScreen({super.key});

  @override
  State<FamilyRecordScreen> createState() => _FamilyRecordScreenState();
}

class _FamilyRecordScreenState extends State<FamilyRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context){
                return Dialog(
                  child: FamilyCreateDialog(),
                );
              });
        },
        backgroundColor: Colors.blueGrey,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );
  }
}
