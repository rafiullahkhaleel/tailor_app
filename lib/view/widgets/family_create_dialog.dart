import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/provider/family_create_provide.dart';
import 'package:tailor_app/view/widgets/custom_button.dart';
import 'package:tailor_app/view/widgets/custom_field.dart';

class FamilyCreateDialog extends StatefulWidget {
  const FamilyCreateDialog({super.key});

  @override
  State<FamilyCreateDialog> createState() => _FamilyCreateDialogState();
}

class _FamilyCreateDialogState extends State<FamilyCreateDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Consumer<FamilyCreateProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(
                'Create Family',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Form(
                key: provider.formKey,
                child: CustomField(
                  hint: 'Family Head',
                  controller: provider.controller,
                  emptyFieldError: 'Please enter Name',
                ),
              ),
              CustomButton(
                isLoading: provider.isLoading,
                onTap: () {
                  if (provider.formKey.currentState!.validate()) {
                    provider.saveFamily(context);
                  }
                },
                title: 'Create',
              ),
            ],
          );
        },
      ),
    );
  }
}
