import 'package:flutter/material.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.blueGrey,
                labelColor: Colors.blueGrey,
                tabs: [
              Text('Individual Record'),
                  Text('Family Record')
            ]),
            Flexible(
              child: TabBarView(children: [
                Text('Individual'),
                Text('Family')
              ]),
            )
          ],
        ),
      ),
    );
  }
}
