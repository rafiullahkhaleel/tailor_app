import 'package:flutter/material.dart';
import 'package:tailor_app/view/widgets/individual_record_dialog.dart';

class IndividualRecordScreen extends StatefulWidget {
  const IndividualRecordScreen({super.key});

  @override
  State<IndividualRecordScreen> createState() => _IndividualRecordScreenState();
}

class _IndividualRecordScreenState extends State<IndividualRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,
              builder: (context){
            return Dialog(
              child: IndividualRecordDialog(),
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
