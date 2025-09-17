import 'package:flutter/material.dart';

class AppConstants {
  // Base URL


  // static const String baseUrl = 'http://10.214.52.68:3002/api';

  static const String baseUrl = 'http://192.168.1.90:3002/api'; //(maison-canal)

  // static const String baseUrl = 'http://192.168.16.108:3002/api'; //(maison-cec)


  // static const String baseUrl = 'http://192.168.1.72:3002/api'; // (Lab)
  


  // API Endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/utilisateurs/register';
  static const String forgotPassword = '$baseUrl/utilisateurs/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String otpcode = '$baseUrl/utilisateurs/verify-otp';
  static const String createLogement = '$baseUrl/logements';
  static const String getHoteId = '$baseUrl/logements/my-hote-id';
}

class AppColors {
  // Couleurs primaires
  static const Color primaryPink = Color(0xFFF6A1ED);
  static const Color primaryGold = Color(0xFFC7AC33);

  // Couleurs secondaires
  static const Color secondaryBeige = Color(0xFFD7AF78);
  static const Color secondaryRed = Color(0xFF852318);
  static const Color secondaryLight = Color(0xFFF3E5F5);

}