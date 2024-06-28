import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomButton({
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Color(0xFF696969), width: 1)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 10, horizontal: 17)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Color.fromRGBO(170, 68, 101, 1.0)),
          ),
        ],
      ),
    );
  }
}
