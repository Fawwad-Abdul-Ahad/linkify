import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  CommonText({super.key,required this.text,required this.textSize,required this.fontWeightText,required this.textColor, this.textAlignText});
  String text;
  Color textColor;
  double textSize;
  FontWeight fontWeightText;
  TextAlign? textAlignText;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlignText,
      text,style:GoogleFonts.poppins(color: textColor,fontSize: textSize,fontWeight: fontWeightText,));
  }
}