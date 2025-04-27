import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedImageTextCard extends StatelessWidget {
  final String imagePath;
  final bool isSvg; // New parameter to identify SVG
  final String title;
  final String? subtitle;
  final double imageRadius;
  final double imageSize;
  final EdgeInsets padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? backgroundColor;
  final Color? imageColor; // For SVG color tinting
  final VoidCallback? onTap;

  const RoundedImageTextCard({
    Key? key,
    required this.imagePath,
    this.isSvg = false, // Default to non-SVG
    required this.title,
    this.subtitle,
    this.imageRadius = 20.0,
    this.imageSize = 48.0,
    this.padding = const EdgeInsets.all(12.0),
    this.titleStyle,
    this.subtitleStyle,
    this.backgroundColor,
    this.imageColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).cardColor,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(imageRadius),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              // Rounded Image Container
              ClipRRect(
                borderRadius: BorderRadius.circular(imageRadius),
                child: isSvg
                    ? SvgPicture.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  color: imageColor,
                )
                    : Image.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Text Content (unchanged)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: subtitleStyle ?? Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}