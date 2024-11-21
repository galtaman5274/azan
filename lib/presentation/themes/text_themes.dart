// text_themes.dart
part of 'main_theme.dart';

class AppTextTheme {
  static String mainFont = 'IndieFlower';

  static TextTheme lightTextTheme = const TextTheme(
    labelMedium: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    labelSmall: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    displayMedium: TextStyle(
        fontFamily: 'IndieFlower',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight),
    displaySmall: TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 12,
      color: AppColors.primaryLight,
    ),
    titleMedium: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    titleLarge: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    displayLarge: TextStyle(
        fontFamily: 'Macondo', fontSize: 15, color: AppColors.primaryDark),
    bodyLarge: TextStyle(
        fontFamily: 'Macondo', fontSize: 15, color: AppColors.primaryDark),
  );

  static TextTheme darkTextTheme = const TextTheme(
    labelMedium: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight),
    labelSmall: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight),
    displayMedium: TextStyle(
        fontFamily: 'IndieFlower',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight),
    displaySmall: TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 18,
      color: AppColors.primaryLight,
    ),
    titleMedium: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    titleLarge: TextStyle(
        fontFamily: 'Macondo',
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark),
    displayLarge: TextStyle(
        fontFamily: 'LibreBaskerville',
        fontSize: 15,
        color: AppColors.primaryLight),
    bodyLarge: TextStyle(
        fontFamily: 'LibreBaskerville',
        fontSize: 15,
        color: AppColors.primaryLight),
  );
}
