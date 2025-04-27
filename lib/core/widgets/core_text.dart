import 'package:flutter/material.dart';

class CoreLevel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final bool? enableInteractiveSelection;

  // Icon related parameters
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsets? iconPadding;
  final VisualDensity? visualDensity;
  final List<BoxShadow>? iconShadow;
  final BoxConstraints? iconConstraints;

  const CoreLevel({
    Key? key,
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.enableInteractiveSelection,

    // Icon parameters
    this.icon,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.visualDensity,
    this.iconShadow,
    this.iconConstraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );

    // If no icon is provided, return just the text
    if (icon == null) {
      return textWidget;
    }

    // Build the icon widget with all customizable properties
    Widget iconWidget = Icon(
      icon,
      size: iconSize,
      color: iconColor,
    );

    // Apply shadow if provided
    if (iconShadow != null) {
      iconWidget = DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: iconShadow,
        ),
        child: iconWidget,
      );
    }

    // Apply constraints if provided
    if (iconConstraints != null) {
      iconWidget = ConstrainedBox(
        constraints: iconConstraints!,
        child: iconWidget,
      );
    }

    // Apply visual density if provided
    if (visualDensity != null) {
      iconWidget = Theme(
        data: Theme.of(context).copyWith(
          visualDensity: visualDensity,
        ),
        child: iconWidget,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: iconPadding ?? const EdgeInsets.only(right: 8.0),
          child: iconWidget,
        ),
        Flexible(child: textWidget),
      ],
    );
  }
}