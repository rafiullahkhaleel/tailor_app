import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/family/family_member_dialog_provider.dart';

import 'custom_button.dart';
import 'custom_field.dart';

class FamilyMemberDialog extends StatefulWidget {
  final String id;
  final String title;
  const FamilyMemberDialog({super.key, required this.id, required this.title});

  @override
  State<FamilyMemberDialog> createState() => _FamilyMemberDialogState();
}

class _FamilyMemberDialogState extends State<FamilyMemberDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyMemberDialogProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Center(
                  child: Text(
                    provider.nameController.text.isEmpty
                        ? 'Name'
                        : provider.nameController.text,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomField(
                  controller: provider.nameController,
                  emptyFieldError: 'Please enter Name',
                  hint: 'Name',
                  onChanged: (val) {
                    provider.notify();
                  },
                ),
                CustomField(
                  controller: provider.relationController,
                  emptyFieldError: 'Please enter Name',
                  hint: 'Relation',
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
                        hint: 'Height',
                        controller: provider.heightController,
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter Width',
                        hint: 'Width',
                        controller: provider.widthController,
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
                        hint: 'Sleeve',
                        controller: provider.sleeveController,
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter neckband measure',
                        hint: 'Neckband',
                        controller: provider.neckbandController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .365,
                  child: CustomField(
                    emptyFieldError: 'Please enter back yoke measure',
                    hint: 'Back yoke',
                    controller: provider.backYokeController,
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
                        hint: 'Height',
                        controller: provider.pantsHeightController,
                      ),
                    ),

                    Expanded(
                      child: CustomField(
                        emptyFieldError: 'Please enter paina measure',
                        hint: 'Paina',
                        controller: provider.painaController,
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
                          provider.notify();
                        },
                        title: 'Clear',
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        isLoading: provider.isLoading,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        onTap: () {
                          provider.familyMemberData(context, widget.id,widget.title);
                        },
                        title: 'Save',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
