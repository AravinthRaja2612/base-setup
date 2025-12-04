import 'package:flutter/material.dart';

enum TextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class AppTextWidget extends StatelessWidget {
  final String text;
  final TextType type;
  final TextAlign? textAlign;

  // Custom style overrides
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;

  // Additional text behavior options
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDirection? textDirection;
  final StrutStyle? strutStyle;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;

  const AppTextWidget({
    super.key,
    required this.text,
    required this.type,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.decoration,
    this.fontStyle,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.strutStyle,
    this.textHeightBehavior,
    this.textScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    // Base TextTheme
    final textTheme = Theme.of(context).textTheme;
    TextStyle? style;

    switch (type) {
      case TextType.displayLarge:
        style = textTheme.displayLarge;
        break;
      case TextType.displayMedium:
        style = textTheme.displayMedium;
        break;
      case TextType.displaySmall:
        style = textTheme.displaySmall;
        break;
      case TextType.headlineLarge:
        style = textTheme.headlineLarge;
        break;
      case TextType.headlineMedium:
        style = textTheme.headlineMedium;
        break;
      case TextType.headlineSmall:
        style = textTheme.headlineSmall;
        break;
      case TextType.titleLarge:
        style = textTheme.titleLarge;
        break;
      case TextType.titleMedium:
        style = textTheme.titleMedium;
        break;
      case TextType.titleSmall:
        style = textTheme.titleSmall;
        break;
      case TextType.bodyLarge:
        style = textTheme.bodyLarge;
        break;
      case TextType.bodyMedium:
        style = textTheme.bodyMedium;
        break;
      case TextType.bodySmall:
        style = textTheme.bodySmall;
        break;
      case TextType.labelLarge:
        style = textTheme.labelLarge;
        break;
      case TextType.labelMedium:
        style = textTheme.labelMedium;
        break;
      case TextType.labelSmall:
        style = textTheme.labelSmall;
        break;
    }

    // Default color logic
    final Color defaultColor = color ?? (isDark ? Colors.white : Colors.black);

    // Apply custom overrides
    style = style?.copyWith(
      color: defaultColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontStyle: fontStyle,
    );

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
    );
  }
}
