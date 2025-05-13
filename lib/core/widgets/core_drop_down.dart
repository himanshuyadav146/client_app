import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CoreDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Widget Function(T)? itemBuilder;
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
  final FormFieldValidator<T>? validator;

  const CoreDropdown({
    Key? key,
    required this.items,
    this.value,
    this.hintText,
    this.labelText,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.style,
    this.decoration,
    this.itemBuilder,
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
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 16,
            ),
          ),
      onChanged: enabled ? onChanged : null,
      style: style ?? Theme.of(context).textTheme.titleMedium,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child:
              itemBuilder != null ? itemBuilder!(item) : Text(item.toString()),
        );
      }).toList(),
      validator: validator,
      isExpanded: true,
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
