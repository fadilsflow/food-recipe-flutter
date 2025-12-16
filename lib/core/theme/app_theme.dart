import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF2A2D3E);
  static const Color accentColor = Color(0xFFFF6584);
  static const Color scaffoldBackgroundColor = Color(0xFFF0F2F5);
  static const Color surfaceColor = Colors.white;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF4834D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
     colors: [Colors.white, Color(0xFFF8FAFC)],
     begin: Alignment.topCenter,
     end: Alignment.bottomCenter,
  );

  // Text Styles
  static TextStyle get displayLarge => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      );

  static TextStyle get displayMedium => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        color: Colors.grey[800],
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        color: Colors.grey[600],
      );

  // Input Decoration
  static InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
