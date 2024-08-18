import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      height: 40.h,
      width: 184.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Center(
          child: Text(
            'Login',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}