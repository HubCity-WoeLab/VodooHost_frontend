import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'widget/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vodoohost',
      theme: ThemeData(
        primaryColor: AppColors.primaryPink,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryPink,
          secondary: AppColors.secondaryBeige,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryGold,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryRed,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}