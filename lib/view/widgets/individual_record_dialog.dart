import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual_dialog_provider.dart';
import 'package:tailor_app/view/widgets/custom_button.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';

class IndividualRecordDialog extends StatefulWidget {
  const IndividualRecordDialog({super.key});

  @override
  State<IndividualRecordDialog> createState() => _IndividualRecordDialogState();
}

class _IndividualRecordDialogState extends State<IndividualRecordDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Consumer<IndividualDialogProvider>(
        builder: (context, provider, child) {
          return Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Center(
                  child: Text(
                    provider.nameController.text.isEmpty
                        ? 'Client'
                        : provider.nameController.text,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomField(
                  emptyFieldError: 'Please enter Name',
                  hint: 'Name',
                  controller: provider.nameController,
                  onChanged: (value) {
                    provider.notify();
                  },
                ),
                Text(
                  'Shirt',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter Height',
                        controller: provider.heightController,
                        hint: 'Height',
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter Width',
                        controller: provider.widthController,
                        hint: 'Width',
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter sleeve measure',
                        controller: provider.sleeveController,
                        hint: 'Sleeve',
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter neckband measure',
                        controller: provider.neckbandController,
                        hint: 'Neckband',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .365,
                  child: CustomField(
                    emptyFieldError: 'Please enter back yoke measure',
                    controller: provider.backYokeController,
                    hint: 'Back yoke',
                  ),
                ),
                Text(
                  'Pants',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter Height',
                        controller: provider.pantsHeightController,
                        hint: 'Height',
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter paina measure',
                        controller: provider.painaController,
                        hint: 'Paina',
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: CustomButton(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        onTap: () {
                          provider.clear();
                        },
                        title: 'Clear',
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        onTap: () {},
                        title: 'Save',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
