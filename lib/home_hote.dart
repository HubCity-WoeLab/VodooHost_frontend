import 'package:flutter/material.dart';
import 'widget/constants.dart';
import 'annonces.dart';
import 'reservations.dart';
import 'calendrier.dart';
import 'messages.dart';
import 'profil.dart';

class HomeHotePage extends StatefulWidget {
  const HomeHotePage({super.key});

  @override
  State<HomeHotePage> createState() => _HomeHotePageState();
}

class _HomeHotePageState extends State<HomeHotePage> {
  int _currentIndex = 0;

  // Liste des pages associées à chaque onglet
  final List<Widget> _pages = [
    const AnnoncesPage(),
    const ReservationsPage(),
    const CalendrierPage(),
    const MessagesPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryPink, // Active icon color
        unselectedItemColor: Colors.black, // Inactive icons color
        type: BottomNavigationBarType.fixed, // Ensures all icons are visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Annonces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Réservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}