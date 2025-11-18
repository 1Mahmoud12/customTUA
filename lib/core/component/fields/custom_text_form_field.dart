import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/themes/styles.dart';
import 'package:tua/core/utils/app_icons.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? nameField;
  final String? helperText;
  final bool? arabicLanguage;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final bool? password;
  final int? maxLines;
  final TextInputType? textInputType;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? enabledBorder;
  final double? fontSizeHintText;
  final double? height;
  final double? width;
  final EdgeInsets? contentPadding;
  final EdgeInsets? outPadding;
  final double? borderRadius;
  final bool? validationOnNumber;
  final bool? enable;
  final bool showCounter;
  final Key? validateKey;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChange;
  final Function? validator;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.password = false,
    this.maxLines,
    this.textInputType,
    this.fillColor,
    this.fontSizeHintText,
    this.focusedBorderColor,
    this.validationOnNumber,
    this.labelText,
    this.nameField,
    this.height,
    this.width,
    this.enable = true,
    this.enabledBorder,
    this.borderRadius,
    this.contentPadding,
    this.onChange,
    this.outPadding,
    this.validateKey,
    this.autoValidateMode,
    this.hintStyle,
    this.inputFormatters,
    this.validator,
    this.helperText,
    this.focusNode,
    this.arabicLanguage,
    this.showCounter = false,
    this.labelStyle,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.password!;
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, minTextAdapt: true);

    // Determine if we should use fixed height mode
    final bool useFixedHeight = widget.height != null;

    return Container(
      padding: widget.outPadding ?? EdgeInsets.zero,
      width: widget.width ?? MediaQuery.of(context).size.width,
      // Remove height constraint from the outer container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 40),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 35, offset: Offset(0, 9), spreadRadius: -4)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.nameField != null) Text(widget.nameField!.tr(), style: Styles.style14500),
          if (widget.nameField != null) SizedBox(height: 6.h),
          SizedBox(
            height: widget.height,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                TextFormField(
                  enabled: widget.enable,
                  obscureText: _obscureText,
                  controller: widget.controller,
                  keyboardType: widget.textInputType ?? TextInputType.visiblePassword,
                  style: TextStyle(color: AppColors.textColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    widget.onChange?.call(value);
                    if (widget.showCounter) {
                      setState(() {});
                    }
                  },
                  validator: widget.validator != null ? (value) => widget.validator!(value) : (value) => value!.isEmpty ? 'Empty Field'.tr() : null,
                  inputFormatters: widget.inputFormatters,
                  // Only set maxLines if we're not using fixed height mode
                  maxLines: useFixedHeight ? null : (widget.maxLines ?? 1),
                  autovalidateMode: widget.autoValidateMode,
                  // Set expands only if we're using fixed height
                  expands: useFixedHeight,
                  cursorColor: AppColors.textColorTextFormField,
                  focusNode: widget.focusNode,
                  textAlignVertical: useFixedHeight ? TextAlignVertical.center : null,
                  decoration: InputDecoration(
                    hintText: widget.hintText.tr(),
                    hintStyle:
                        widget.hintStyle ??
                        TextStyle(color: AppColors.greyG900, fontSize: (widget.fontSizeHintText ?? 14).sp, fontWeight: FontWeight.w400),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon:
                        widget.password == true
                            ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(onTap: _toggle, child: SvgPicture.asset(_obscureText ? AppIcons.hidePassword : AppIcons.passwordShow)),
                            )
                            : widget.suffixIcon,
                    labelText: widget.labelText,
                    labelStyle: widget.labelStyle ?? Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: widget.fillColor ?? AppColors.transparent,
                    contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 40)),
                      borderSide: BorderSide(color: widget.enabledBorder ?? AppColors.greyBorderColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 40)),
                      borderSide: BorderSide(color: widget.focusedBorderColor ?? AppColors.cRadioColor, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 40)),
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 40)),
                      borderSide: BorderSide(color: widget.focusedBorderColor ?? AppColors.primaryColor, width: 1.5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 40)),
                      borderSide: BorderSide(color: widget.enabledBorder ?? AppColors.greyBorderColor, width: 1.5),
                    ),
                    errorStyle: TextStyle(fontSize: 12.sp, color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                  ),
                ),
                if (widget.showCounter)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(widget.controller.text.length.toString(), style: Theme.of(context).textTheme.labelSmall),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
