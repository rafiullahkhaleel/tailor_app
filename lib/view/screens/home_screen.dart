import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app/view/screens/family/family_record_screen.dart';
import 'package:tailor_app/view/screens/individual/individual_record_screen.dart';
import 'package:tailor_app/view/screens/auth/login_screen.dart';

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
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                onTap: ()async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                leading: Icon(Icons.logout,color: Colors.blueGrey,),
                title: Text('Sign out',style: TextStyle(color: Colors.blueGrey),),)
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
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
