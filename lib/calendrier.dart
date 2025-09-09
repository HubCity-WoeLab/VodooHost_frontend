import 'package:flutter/material.dart';
import 'widget/constants.dart';

class CalendrierPage extends StatelessWidget {
  const CalendrierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendrier'),
          backgroundColor: AppColors.primaryPink, // Pink background for AppBar
          bottom: TabBar(
            labelColor: AppColors.primaryGold, // Active tab text color
            unselectedLabelColor: Colors.black, // Inactive tab text color
            indicatorColor: AppColors.primaryGold, // Gold indicator
            labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Bold active tab
            tabs: const [
              Tab(text: 'Logements'),
              Tab(text: 'Rituels'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LogementsSection(),
            RituelsSection(),
          ],
        ),
      ),
    );
  }
}

class LogementsSection extends StatelessWidget {
  const LogementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenu pour mettre à jour les disponibilités des logements'),
    );
  }
}

class RituelsSection extends StatelessWidget {
  const RituelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenu pour définir une date pour les rituels'),
    );
  }
}