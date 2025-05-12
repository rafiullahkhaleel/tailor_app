import 'package:flutter/material.dart';
import 'package:tailor_app/view/widgets/individual_update_dialog.dart';

class IndividualDetailScreen extends StatefulWidget {
  final String name;
  final String length;
  final String width;
  final String sleeve;
  final String neckBand;
  final String backYoke;
  final String pantLength;
  final String paina;
  final String id;
  final String address;
  final String phoneNo;
  const IndividualDetailScreen({
    super.key,
    required this.name,
    required this.length,
    required this.width,
    required this.sleeve,
    required this.neckBand,
    required this.backYoke,
    required this.pantLength,
    required this.paina,
    required this.id, required this.address, required this.phoneNo,
  });

  @override
  State<IndividualDetailScreen> createState() => _IndividualDetailScreenState();
}

class _IndividualDetailScreenState extends State<IndividualDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          spacing: 15,
          children: [
            Text(
              'Shirt',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Length'),
                        MyText(title: '${widget.length} inch'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Width'),
                        MyText(title: '${widget.width} inch'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Sleeve'),
                        MyText(title: '${widget.sleeve} inch'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Neckband'),
                        MyText(title: '${widget.neckBand} inch'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Back yoke'),
                        MyText(title: '${widget.backYoke} inch'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Pant',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Length'),
                        MyText(title: '${widget.pantLength} inch'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Paina'),
                        MyText(title: '${widget.paina} inch'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Phone No',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    MyText(title: widget.phoneNo,),
                  ],
                ),
              ),
            ),
            Text(
              'Address',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    MyText(title: widget.address,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(child: IndividualUpdateDialog(id: widget.id,));
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        shape: CircleBorder(),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String title;
  const MyText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: Colors.black, fontSize: 18));
  }
}
