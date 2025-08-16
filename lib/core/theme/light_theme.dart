

import '../../exports.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF34C8E8); // #34C8E8
  static const Color secondaryColor = Color(0xFF4E4AF2); // #4E4AF2
  static const Color backgroundColor = Color(0xff252c3a);
  static const Color surfaceColor = Color(0xFF1E293B);
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFB3C6D5);

  // Poppins Font Helper
  static const String fontFamily = 'Poppins';
  
  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight lightWeight = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
    stops: [0.0, 1.0],
  );

  static final secondaryGradient = LinearGradient(
  colors: [
    Colors.grey.withValues(alpha: .1), // Light fade
    Colors.grey.withValues(alpha: .3), // Medium fade
    Colors.grey.withValues(alpha: .5), // Dark fade
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.5, 1.0],
  transform: GradientRotation(-0.2),
);

  // Reverse Gradient (optional)
  static const LinearGradient reverseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, primaryColor],
    stops: [0.0, 1.0],
  );

  // Text Theme
  static TextTheme get textTheme => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: bold,
          color: textColor,
          fontFamily: fontFamily,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: semiBold,
          color: textColor,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondaryColor,
          fontFamily: fontFamily,
        ),
      );

  // Elevated Button Theme
  static ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // We'll use gradient via Ink (see below)
        ),
      );

  // App Bar Theme
  static AppBarTheme appBarTheme(BuildContext context) =>  AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight:context.screenHeight *0.09,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      );

  // Overall ThemeData
  static ThemeData light(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Poppins', // Set Poppins as primary font
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: backgroundColor,
        ),
        textTheme: textTheme,
        appBarTheme: appBarTheme(context),
        elevatedButtonTheme: elevatedButtonTheme,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: textSecondaryColor),
        ),
        useMaterial3: true,
      );
}