import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../configs/Palette.dart';
import '../../configs/app_fonts.dart';
import '../../configs/box.dart';

class MyTextField extends StatelessWidget {
  final bool? required;
  final bool obscureText;
  final bool enable;
  final bool readOnly;
  final String? hintText;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final String? title;
  final String? prefixText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onSubmit;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? errorText;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextStyle? style;
  final EdgeInsets? contentPadding;
  final Color? cursorColor;
  final Color? fillColor;
  final bool autoFocus;
  final bool hasBorder;
  final bool isDense;
  final InputBorder? inputBorder;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter> inputFormatters;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;

  const MyTextField(
      {Key? key,
      this.suffixIcon,
      this.hintText,
      this.maxLength,
      this.maxLine,
      this.minLine,
      this.required,
      this.obscureText = false,
      this.controller,
      this.title,
      this.keyboardType,
      this.validator,
      this.enable = true,
      this.readOnly = false,
      this.titleStyle,
      this.hintStyle,
      this.onTap,
      this.onChanged,
      this.focusNode,
      this.onSaved,
      this.onEditingComplete,
      this.errorText,
      this.labelText,
      this.labelStyle,
      this.prefixIcon,
      this.style,
      this.prefix,
      this.prefixText,
      this.contentPadding,
      this.cursorColor = Palette.black,
      this.fillColor = Palette.white,
      this.autoFocus = false,
      this.hasBorder = false,
      this.isDense = false,
      this.inputFormatters = const [],
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.textAlign = TextAlign.start,
      this.textInputAction,
      this.onSubmit,
      this.inputBorder = const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Palette.white))})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleField(
          title: title,
          required: required,
          style: titleStyle,
        ),
        BoxMain.h(4),
        TextFormField(
          onFieldSubmitted: onSubmit,
          textAlign: textAlign,
          autofocus: autoFocus,
          inputFormatters: inputFormatters,
          cursorHeight: 22.h,
          cursorWidth: 1.5.w,
          cursorColor: cursorColor,
          minLines: minLine,
          obscureText: obscureText,
          onSaved: (_) => onSaved,
          maxLines: maxLine ?? 1,
          maxLength: maxLength,
          onTap: onTap,
          focusNode: focusNode,
          onChanged: onChanged,
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          enabled: enable,
          keyboardType: keyboardType,
          style: style ?? AppFont.t.hint,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              border: hasBorder ? inputBorder : InputBorder.none,
              disabledBorder: hasBorder ? inputBorder : InputBorder.none,
              enabledBorder: hasBorder ? inputBorder : InputBorder.none,
              focusedBorder: hasBorder ? inputBorder : InputBorder.none,
              errorBorder: hasBorder ? inputBorder : InputBorder.none,
              focusedErrorBorder: hasBorder ? inputBorder : InputBorder.none,
              contentPadding: contentPadding,
              counterText: '',
              errorText: errorText,
              fillColor: fillColor,
              filled: true,
              hintText: hintText,
              hintStyle: hintStyle ?? AppFont.t.hint,
              focusColor: Palette.grayF6,
              suffixIcon: suffixIcon,
              labelText: labelText,
              labelStyle: labelStyle,
              prefixText:prefixText ,
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixIconConstraints,
              prefix: prefix,
              isDense: isDense,
              suffixIconConstraints: suffixIconConstraints,
              alignLabelWithHint: (maxLine != null && maxLine! > 1)),
        ),
      ],
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    Key? key,
    this.title,
    this.style,
    this.required,
  }) : super(key: key);

  final String? title;
  final TextStyle? style;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return title != null
        ? Text.rich(
            TextSpan(
              text: title ?? '',
              style: style ?? AppFont.t,
              children: [
                if (required ?? false)
                  TextSpan(
                    text: ' *',
                    style: AppFont.t.red,
                  ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
