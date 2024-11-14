import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SquareTileWidget extends StatelessWidget {
  const SquareTileWidget({super.key, required this.svgPath});
  final String svgPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(16.w),
        color: Colors.grey[200],
      ),
      child: SvgPicture.asset(
        svgPath,
        height: 40,
      ),
    );
  }
}
