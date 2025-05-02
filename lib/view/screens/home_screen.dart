import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            Center(child: Text('Hello')),
            Center(child: Text('Hello2')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
                backgroundColor: Colors.blueGrey,
          shape: CircleBorder(),
          child: Icon(Icons.add,color: Colors.white,size: 40,),
        ),
      ),
    );
  }
}
