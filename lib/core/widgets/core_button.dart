import 'package:flutter/material.dart';

class CoreButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final bool isLoading;
  final Widget? icon;
  final bool isDisabled;

  CoreButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.shape,
    this.isLoading = false,
    this.icon,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          side: isDisabled ? BorderSide(color: Colors.black) : null,
          foregroundColor:
              isDisabled ? Colors.black : textColor ?? Colors.white,
          backgroundColor: isDisabled
              ? Colors.white
              : backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //  shape: shape ?? ShapeBorder(),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(textColor ?? Colors.white),
                  strokeWidth: 2,
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon!,
                      SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(fontSize: fontSize ?? 16),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(fontSize: fontSize ?? 16),
                  ),
      ),
    );
  }
}
