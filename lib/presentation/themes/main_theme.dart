// main_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'text_themes.dart';
part 'app_colors.dart';

enum AppFonts { primaryFont, secondaryFont }

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            return AppColors.primaryDark;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.primaryDark,
        backgroundColor: AppColors.primaryLight,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.primaryLight,
        backgroundColor: AppColors.accentColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.accentColor,
      ),
      textTheme: AppTextTheme.lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.primaryLight,
        backgroundColor: AppColors.primaryDark,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.primaryLight,
        backgroundColor: AppColors.accentColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.accentColor,
      ),
      textTheme: AppTextTheme.darkTextTheme,
    );
  }
}
