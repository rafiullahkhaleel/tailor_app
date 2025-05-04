import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  final double fontSize;
  final FontWeight fontWeight;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false, this.fontSize = 22,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * .07,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey,
        ),
        child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)):
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
