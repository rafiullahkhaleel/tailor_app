import 'package:flutter/material.dart';
import 'package:tailor_app/view/screens/family_record_screen.dart';
import 'package:tailor_app/view/screens/individual_record_screen.dart';

class HomeScreen extends StatefulWidget {
  final int tabIndex;
  const HomeScreen({super.key, this.tabIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.tabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tailor App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            indicatorColor: Colors.black87,
            tabs: [
              Text(
                'Individual',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              Text(
                'Family',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndividualRecordScreen(),
            FamilyRecordScreen()
          ],
        ),

      ),
    );
  }
}
