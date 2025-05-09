import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/individual_update_provider.dart';

import 'custom_button.dart';
import 'custom_field.dart';

class IndividualUpdateDialog extends StatefulWidget {
  final String id;
  const IndividualUpdateDialog({super.key, required this.id});

  @override
  State<IndividualUpdateDialog> createState() => _IndividualUpdateDialogState();
}

class _IndividualUpdateDialogState extends State<IndividualUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Consumer<IndividualUpdateProvider>(
        builder: (context, provider, child) {
          return Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Center(
                  child: Text(
                    provider.nameController.text.isEmpty
                        ? "Client"
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
                          if(provider.formKey.currentState!.validate()){
                            provider.updateIndividualData(context, widget.id);
                          }
                        },
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
