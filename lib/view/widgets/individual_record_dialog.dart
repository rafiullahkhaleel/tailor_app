import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual_dialog_provider.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';

class IndividualRecordDialog extends StatefulWidget {
  const IndividualRecordDialog({super.key});

  @override
  State<IndividualRecordDialog> createState() => _IndividualRecordDialogState();
}

class _IndividualRecordDialogState extends State<IndividualRecordDialog> {
  @override
  Widget build(BuildContext context) {
    print('build');
    final provider = Provider.of<IndividualDialogProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Column(
        spacing: 20,
        children: [
          Consumer<IndividualDialogProvider>(
            builder: (context, provider, child) {
              return Center(
                child: Text(
                  provider.nameController.text.isEmpty ? 'Client' : provider.nameController.text,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
          CustomField(
            hint: 'Name',
            controller: provider.nameController,
            onChanged: (value) {
              provider.notify();
            },
          ),
        ],
      ),
    );
  }
}
