import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/family_record_provider.dart';
import 'package:tailor_app/view/screens/family_members_screen.dart';
import 'package:tailor_app/view/screens/individual_record_screen.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';
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
    Future.microtask(() {
      Provider.of<FamilyRecordProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyRecordProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(right: 20,left: 20,top: 10),
            child: () {
              final listToShow =
              provider.filterController.text.isEmpty
                  ? provider.snapshot
                  : provider.filteredSnapshot;
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (provider.error != null) {
                return Center(child: Text('ERROR OCCURRED ${provider.error}'));
              } else if(listToShow.isEmpty){
                return Center(child: Text('No data Available',style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),),);
              }else{
                return Column(
                  children: [
                    CustomField(
                      hint: 'Search',
                      controller: provider.filterController,
                      onChanged: (value){
                        provider.filter(value);
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listToShow.length,
                        itemBuilder: (context, index) {
                          final data = listToShow[index];
                          String id = listToShow[index].id;
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              Dismissible(
                                key: Key(id),
                                direction: DismissDirection.horizontal,
                                background: MyContainer(),
                                onDismissed: (value){
                                  provider.delete(id);
                                },
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => FamilyMembersScreen(
                                          title: data['headName'],
                                          id: data['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blueGrey,
                                    child: Text(
                                      data['headName'].isNotEmpty
                                          ? data['headName'][0]
                                          : '',
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
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }(),
             ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: FamilyCreateDialog());
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
