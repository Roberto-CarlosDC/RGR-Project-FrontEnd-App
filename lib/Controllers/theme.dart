import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0D47A1); // Azul mais escuro
  static const Color secondaryColor = Color(0xFF42A5F5); // Azul mais claro
  static const Color iconColor = Colors.grey; // Cinza claro
}

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.iconColor,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor, // Definindo a cor secundária
      ),
    );
  }
}
