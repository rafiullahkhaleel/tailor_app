import 'package:flutter/material.dart';

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

        },
        backgroundColor: Colors.blueGrey,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );
  }
}
