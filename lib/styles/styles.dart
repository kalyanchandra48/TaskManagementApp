import 'package:flutter/material.dart';

// Define the color palette
class AppColors {
  static const Color primaryText =
      Color(0xFF333333); // Dark color for primary text
  static const Color secondaryText =
      Color(0xFF757575); // Lighter grey for secondary text
  static const Color accentColor = Color(0xFF2196F3); // Accent color (blue)
}

// Define text styles
class AppTextStyles {
  // Heading 1: Large bold headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.5,
  );

  // Heading 2: Medium bold headings
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.5,
  );

  // Subheading: Smaller than heading, for secondary titles
  static const TextStyle subheading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    height: 1.4,
  );

  // Body Text: Default body text style
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
    height: 1.6,
  );

  // Body Text Secondary: Lighter color for secondary information
  static const TextStyle bodyTextSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  // Caption: Smaller text for captions or supporting information
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.4,
  );

  // Button Text: Text style for buttons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Link Text: Text style for clickable links
  static const TextStyle linkText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.accentColor,
    decoration: TextDecoration.underline,
  );
}
