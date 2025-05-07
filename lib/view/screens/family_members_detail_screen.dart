import 'package:flutter/material.dart';

import 'individual_detail_screen.dart';

class FamilyMembersDetailScreen extends StatefulWidget {
  final String title;
  final String relation;
  final String length;
  final String width;
  final String sleeve;
  final String neckBand;
  final String backYoke;
  final String pantLength;
  final String paina;
  final String familyHead;
  const FamilyMembersDetailScreen({
    super.key,
    required this.title,
    required this.relation,
    required this.length,
    required this.width,
    required this.sleeve,
    required this.neckBand,
    required this.backYoke,
    required this.pantLength,
    required this.paina,
    required this.familyHead,
  });

  @override
  State<FamilyMembersDetailScreen> createState() =>
      _FamilyMembersDetailScreenState();
}

class _FamilyMembersDetailScreenState extends State<FamilyMembersDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
              '${widget.relation} of ${widget.familyHead}',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
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
          ],
        ),
      ),
    );
    ;
  }
}
