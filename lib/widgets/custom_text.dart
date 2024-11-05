import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.delius(
          textStyle: const TextStyle(
            fontSize: 20,
            color: Color(0xff1A5319),
            fontWeight: FontWeight.w500,
          ),
        )
    );
  }
}
