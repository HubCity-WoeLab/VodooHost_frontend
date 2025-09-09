import 'package:flutter/material.dart';
import 'widget/constants.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Réservations'),
          backgroundColor: AppColors.primaryPink, // Fond rose pour l'AppBar
          bottom: TabBar(
            labelColor: AppColors.primaryGold, // Couleur des écritures actives
            unselectedLabelColor: Colors.black, // Couleur des écritures inactives
            indicatorColor: AppColors.primaryGold, // Indicateur doré
            labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Texte actif en gras
            tabs: const [
              Tab(text: "Aujourd'hui"),
              Tab(text: 'Toutes mes réservations'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReservationsTodaySection(),
            AllReservationsSection(),
          ],
        ),
      ),
    );
  }
}

class ReservationsTodaySection extends StatelessWidget {
  const ReservationsTodaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Contenu des réservations d'aujourd'hui"),
    );
  }
}

class AllReservationsSection extends StatelessWidget {
  const AllReservationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenu de toutes mes réservations'),
    );
  }
}