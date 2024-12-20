import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_constants.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.title,
      this.onTap,
      this.isReverse,
      this.bColor});
  final String title;
  final void Function()? onTap;
  final bool? isReverse;
  final Color? bColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        margin:  EdgeInsets.symmetric(horizontal: 25.w),
        decoration: BoxDecoration(
            color:
                bColor ?? (isReverse == true ? logoImageColor : Colors.black),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: isReverse == true ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
