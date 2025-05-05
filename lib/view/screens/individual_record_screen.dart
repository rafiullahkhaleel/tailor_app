import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual_screen_provider.dart';
import 'package:tailor_app/view/widgets/individual_record_dialog.dart';

class IndividualRecordScreen extends StatefulWidget {
  const IndividualRecordScreen({super.key});

  @override
  State<IndividualRecordScreen> createState() => _IndividualRecordScreenState();
}

class _IndividualRecordScreenState extends State<IndividualRecordScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<IndividualScreenProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IndividualScreenProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: () {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.error != null) {
              return Center(child: Text('ERROR OCCURRED ${provider.error}'));
            } else {
              return ListView.builder(
                itemCount: provider.snapshot.length,
                itemBuilder: (context, index) {
                  final data = provider.snapshot[index];
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            data['name'].isNotEmpty
                                ? provider.snapshot[index]['name'][0]
                                : '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: IndividualRecordDialog());
                },
              );
            },
            backgroundColor: Colors.blueGrey,
            shape: CircleBorder(),
            child: Icon(Icons.add, color: Colors.white, size: 40),
          ),
        );
      },
    );
  }
}
