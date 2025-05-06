import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/family_record_provider.dart';
import 'package:tailor_app/view/widgets/family_create_dialog.dart';

class FamilyRecordScreen extends StatefulWidget {
  const FamilyRecordScreen({super.key});

  @override
  State<FamilyRecordScreen> createState() => _FamilyRecordScreenState();
}

class _FamilyRecordScreenState extends State<FamilyRecordScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      Provider.of<FamilyRecordProvider>(context,listen: false).fetchData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyRecordProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: () {
            if(provider.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }else if(provider.error != null){
              return Center(child: Text('ERROR OCCURRED ${provider.error}'),);
            }else{
              return ListView.builder(
                itemCount: provider.snapshot.length,
                  itemBuilder: (context,index){
                  final data = provider.snapshot[index];
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              data['headName'].isNotEmpty ? data['headName'][0] : '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            data['headName'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          }(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
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
      },
    );
  }
}
