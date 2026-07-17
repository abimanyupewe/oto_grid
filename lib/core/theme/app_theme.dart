import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [AppTheme] mendefinisikan sistem desain visual untuk aplikasi OtoGrid.
///
/// Mengacu pada Style Requirements Specification:
/// - **Primary (Persian Green)**: #2A9D8F
/// - **Secondary (Burnt Orange)**: #E76F51
/// - **Neutral Background**: #FFFFFF (Pure White) & #F8F9FA (Soft Gray)
/// - **Typography/Text (Charcoal)**: #264653
/// - **Typography Family**: Inter
/// - **Corner Radius**: 16dp untuk tombol dan card.
class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFF2A9D8F);
  static const Color secondaryColor = Color(0xFFE76F51);
  static const Color charcoalColor = Color(0xFF264653);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;

  /// Mengembalikan [ThemeData] untuk mode terang (Light Mode).
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: secondaryColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: charcoalColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: charcoalColor,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: charcoalColor,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: charcoalColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56), // Sesuai spec: tinggi minimal 56dp
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: charcoalColor,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
