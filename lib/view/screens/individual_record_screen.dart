import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual_screen_provider.dart';
import 'package:tailor_app/view/screens/individual_detail_screen.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';
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
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
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
                      onChanged: (value) {
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
                                onDismissed: (direction) {
                                  provider.delete(id);
                                },
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => IndividualDetailScreen(
                                              name: data['name'],
                                              length: data['height'],
                                              width: data['width'],
                                              sleeve: data['sleeve'],
                                              neckBand: data['neckband'],
                                              backYoke: data['backYoke'],
                                              pantLength: data['pantsHeight'],
                                              paina: data['paina'],
                                              id: id,
                                            ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blueGrey,
                                    child: Text(
                                      data['name'].isNotEmpty
                                          ? data['name'][0]
                                          : '',
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

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(Icons.delete, color: Colors.white),
        Icon(Icons.delete, color: Colors.white)
      ],),
    );
  }
}
