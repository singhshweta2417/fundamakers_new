import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextFormField({
  FocusNode? focusNode,
  TextInputAction? textInputAction,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  bool? autofocus,
  TextAlignVertical? textAlignVertical,
  bool? enabled,
  TextEditingController? controller,
  Color? cursorColor,
  double? cursorWidth,
  double? cursorHeight,
  ValueChanged<String>? onChanged,
  int? maxLines,
  int? maxLength,
  bool? readOnly,
  bool? obscureText,
  TextInputType? keyboardType,
  TextStyle? style,
  String? labelText,
  double? labelSize,
  FontWeight? labelWeight,
  Color? labelColor,
  String? errorText,
  String? hintText,
  double? hintSize,
  FontWeight? hintWeight,
  Color? hintColor,
  EdgeInsetsGeometry? contentPadding,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool? filled,
  Color? fillColor,
  BorderSide? borderSide,
  BorderRadius? fieldRadius,
  bool? isBottomBorderOnly,
}) {
  return TextFormField(
    focusNode: focusNode,
    textInputAction: textInputAction ?? TextInputAction.done,
    validator: validator,
    onSaved: onSaved,
    autofocus: autofocus ?? false,
    textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
    enabled: enabled,
    controller: controller,
    cursorColor: cursorColor,
    cursorWidth: cursorWidth ?? 2.0,
    cursorHeight: cursorHeight,
    onChanged: onChanged,
    maxLines: maxLines,
    maxLength: maxLength,
    readOnly: readOnly ?? false,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType,
    style: style,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: labelSize ?? 16,
        fontWeight: labelWeight ?? FontWeight.normal,
        color: labelColor ?? Colors.grey,
      ).merge(GoogleFonts.sourceSerif4()),
      errorText: errorText?.isEmpty ?? true ? null : errorText,
      counterText: "",
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: filled ?? true,
      fillColor: fillColor ?? Colors.white,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: hintSize ?? 16,
        fontWeight: hintWeight ?? FontWeight.normal,
        color: hintColor ?? Colors.black.withOpacity(0.5),
      ).merge(GoogleFonts.robotoCondensed()),
      contentPadding: contentPadding ?? const EdgeInsets.only(left: 10, right: 5, top: 0, bottom: 0),
      border: isBottomBorderOnly == true
          ? UnderlineInputBorder(
        borderSide: borderSide ?? BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
      )
          : UnderlineInputBorder(
        borderSide: borderSide ?? BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
      ),
      focusedBorder: isBottomBorderOnly == true
          ? UnderlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.grey),
      )
          : OutlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.grey),
        borderRadius: fieldRadius ?? const BorderRadius.all(Radius.circular(10)),
      ),
      disabledBorder: isBottomBorderOnly == true
          ? UnderlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.grey),
      )
          : OutlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.grey),
        borderRadius: fieldRadius ?? const BorderRadius.all(Radius.circular(5)),
      ),
      enabledBorder: isBottomBorderOnly == true
          ? UnderlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.black),
      )
          : OutlineInputBorder(
        borderSide: borderSide ?? const BorderSide(width: 1, color: Colors.black),
        borderRadius: fieldRadius ?? const BorderRadius.all(Radius.circular(5)),
      ),
    ),
  );
}

