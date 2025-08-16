
import '../../exports.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF34C8E8); // #34C8E8
  static const Color secondaryColor = Color(0xFF4E4AF2); // #4E4AF2
  static const Color backgroundColor = Color(0xff252c3a);
  static const Color surfaceColor = Color(0xFF1E293B);
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFB3C6D5);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
    stops: [0.0, 1.0],
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
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondaryColor,
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
  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  // Overall ThemeData
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          background: backgroundColor,
          surface: surfaceColor,
        ),
        textTheme: textTheme,
        appBarTheme: appBarTheme,
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