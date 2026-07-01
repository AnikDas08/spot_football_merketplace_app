import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    super.key,
    this.maxLines, // null = unlimited lines
    this.textAlign = TextAlign.start, // start is safer than center
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.color = AppColors.black,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.height, // line height support
    this.decoration, // underline / strikethrough
    this.softWrap = true, // enables wrapping
    this.fontFamily,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines; // nullable
  final TextOverflow overflow;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;
  final bool softWrap;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      letterSpacing: letterSpacing,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
    );

    if (fontFamily == 'Montserrat') {
      textStyle = GoogleFonts.montserrat(textStyle: textStyle);
    } else if (fontFamily == 'Poppins') {
      textStyle = GoogleFonts.poppins(textStyle: textStyle);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      textStyle = textStyle.copyWith(fontFamily: 'SFPro');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      textStyle = GoogleFonts.poppins(textStyle: textStyle);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: left.w,
        right: right.w,
        top: top.h,
        bottom: bottom.h,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines, // null = no limit
        overflow:
            maxLines ==
                null // no clip if unlimited
            ? TextOverflow.visible
            : overflow,
        softWrap: softWrap,
        style: textStyle,
      ),
    );
  }
}
