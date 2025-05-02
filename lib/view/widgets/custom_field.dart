import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? emptyFieldError;
  final String? lengthError;
  const CustomField({super.key, required this.hint, required this.controller, this.emptyFieldError, this.lengthError});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black26)
      ),
      validator: (value){
        if(value!.isEmpty){
          return emptyFieldError;
        }else if (value.length < 6){
          return lengthError;
        }else{
          return null;
        }
      },
    );
  }
}
