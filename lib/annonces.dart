import 'package:flutter/material.dart';
import 'widget/constants.dart';
import 'logements.dart';
import 'divinites.dart';
import 'rituels.dart';

class AnnoncesPage extends StatelessWidget {
  const AnnoncesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Annonces'),
          backgroundColor: AppColors.primaryPink,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.add, color: Colors.white),
              onSelected: (value) {
                if (value == 'Logements') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Logements()),
                  );
                } else if (value == 'Divinités') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Divinites()),
                  );
                } else if (value == 'Rituels') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Rituels()),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Logements',
                  child: Text('Ajouter un Logement'),
                ),
                const PopupMenuItem(
                  value: 'Divinités',
                  child: Text('Ajouter une Divinité'),
                ),
                const PopupMenuItem(
                  value: 'Rituels',
                  child: Text('Ajouter un Rituel'),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            labelColor: AppColors.primaryGold,
            unselectedLabelColor: Colors.black,
            indicatorColor: AppColors.primaryGold,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Logements'),
              Tab(text: 'Divinités'),
              Tab(text: 'Rituels'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Logements(),
            Divinites(),
            Rituels(),
          ],
        ),
      ),
    );
  }
}