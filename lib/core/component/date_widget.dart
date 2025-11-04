import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tua/core/utils/app_icons.dart';
import 'package:tua/core/utils/constant_gaping.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.date),
        w5,
        Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
