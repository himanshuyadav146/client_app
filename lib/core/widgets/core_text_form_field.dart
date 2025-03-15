import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoreTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? expands;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool? filled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;

  const CoreTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.decoration,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.expands,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: labelText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
            filled: filled,
            border: border,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            disabledBorder: disabledBorder,
            contentPadding: contentPadding,
          ),
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      style: style,
      textAlign: textAlign,
      autofocus: autofocus,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      expands: expands ?? false,
      textCapitalization: textCapitalization,
    );
  }
}
