import 'package:flutter/material.dart';
import 'favorites.dart';
import 'explore.dart';
import 'travel.dart';
import 'chat.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    "Explore",
    "Favoris",
    "Voyages",
    "Message",
    "Profile",
  ];

  final List<IconData> _icons = [
    Icons.search,
    Icons.favorite_border,
    Icons.card_travel,
    Icons.message_outlined,
    Icons.person_outline,
  ];

  final List<Widget> _pages = [
    const RealEstatePage(),
    const FavorisPage(),
    const TripsPage(),
    const InboxPage(),
    const Center(child: Text("Profile Page")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.brown, // Couleur sélectionnée (rouge/brun)
        unselectedItemColor: Colors.grey, // Couleur non sélectionnée
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: List.generate(
          _titles.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(_icons[index]),
            label: _titles[index],
          ),
        ),
      ),
    );
  }
}
