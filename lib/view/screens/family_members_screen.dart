import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/view/screens/family_members_detail_screen.dart';
import 'package:tailor_app/view/widgets/family_member_dialog.dart';

import '../../provider/family_member_provider.dart';

class FamilyMembersScreen extends StatefulWidget {
  final String title;
  final String id;

  const FamilyMembersScreen({super.key, required this.title, required this.id});

  @override
  State<FamilyMembersScreen> createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FamilyMemberProvider>(
        context,
        listen: false,
      ).fetchData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyMemberProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Family of ${widget.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
          ),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => FamilyMembersDetailScreen(
                                    title: data['name'],
                                    relation: data['relation'],
                                    length: data['height'],
                                    width: data['width'],
                                    sleeve: data['sleeve'],
                                    neckBand: data['neckband'],
                                    backYoke: data['backYoke'],
                                    pantLength: data['pantsHeight'],
                                    paina: data['paina'],
                                    familyHead: widget.title,
                                  ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            data['name'].isNotEmpty ? data['name'][0] : '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          data['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
                  return Dialog(
                    child: FamilyMemberDialog(
                      id: widget.id,
                      title: widget.title,
                    ),
                  );
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
