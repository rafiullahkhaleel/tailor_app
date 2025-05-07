import 'package:flutter/material.dart';
import 'package:tailor_app/view/widgets/family_member_dialog.dart';

class FamilyMembersScreen extends StatefulWidget {
  final String title;
  final String id;
  const FamilyMembersScreen({super.key, required this.title, required this.id});

  @override
  State<FamilyMembersScreen> createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context,
                builder: (context){
              return Dialog(
                child: FamilyMemberDialog(id: widget.id,),
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
