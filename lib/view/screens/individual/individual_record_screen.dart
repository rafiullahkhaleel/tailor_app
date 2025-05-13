import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual/individual_screen_provider.dart';
import 'package:tailor_app/view/screens/individual/individual_detail_screen.dart';
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
        final list = provider.filterController.text.isEmpty
            ? provider.allList
            : provider.filteredList;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : provider.error != null
                ? Center(child: Text('ERROR: ${provider.error}'))
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomField(
                  hint: 'Search',
                  controller: provider.filterController,
                  onChanged: (value){
                    provider.filter(value);
                  },
                ),
                list.isEmpty ? Expanded(
                  child: Column(
                    children: [
                      Spacer(),
                      Center(child: Text('No Data Found',style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),)),
                      Spacer(),
                    ],
                  ),
                ) :
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          Dismissible(
                            key: Key(item.id),
                            direction:
                            DismissDirection.horizontal,
                            background: MyContainer(),
                            onDismissed: (_) {
                              provider.delete(item.id);
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        IndividualDetailScreen(
                                          name: item.name,
                                          length: item.height,
                                          width: item.width,
                                          sleeve: item.sleeve,
                                          neckBand: item.neckband,
                                          backYoke: item.backYoke,
                                          pantLength:
                                          item.pantsHeight,
                                          paina: item.paina,
                                          id: item.id,
                                          address: item.address,
                                          phoneNo: item.phoneNo,
                                        ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                                child: Text(
                                  item.name.isNotEmpty
                                      ? item.name[0]
                                      : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                item.name,
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
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(child: IndividualRecordDialog()),
              );
            },
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.add, size: 35, color: Colors.white),
          ),
        );
      },
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      child: Icon(Icons.delete, color: Colors.white),
    );
  }
}
