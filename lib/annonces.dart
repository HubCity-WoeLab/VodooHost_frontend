import 'dart:io'; // Import the dart:io library
import 'package:flutter/material.dart';
import 'widget/constants.dart';
import 'logements.dart';
import 'divinites.dart';
import 'rituels.dart';

class AnnoncesPage extends StatefulWidget {
  const AnnoncesPage({super.key});

  @override
  State<AnnoncesPage> createState() => _AnnoncesPageState();
}

class _AnnoncesPageState extends State<AnnoncesPage> {
  final List<Map<String, dynamic>> _logements = []; // Store all logement data

  void _addLogement(Map<String, dynamic> logement) {
    setState(() {
      logement['status'] = 'En attente'; // Default status
      _logements.add(logement);
    });
  }

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
                    MaterialPageRoute(
                      builder: (context) => Logements(onAddLogement: _addLogement),
                    ),
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
        body: TabBarView(
          children: [
            _buildLogementsTab(),
            const Divinites(),
            const Rituels(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _logements.length,
      itemBuilder: (context, index) {
        final logement = _logements[index];
        final List<String> photos = List<String>.from(logement['photos'] ?? []);
        final String status = logement['status'] ?? 'En attente';

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (photos.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: photos.length,
                        itemBuilder: (context, photoIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(photos[photoIndex]),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'Validé'
                                ? Colors.green
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.home, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          logement['nom'] ?? 'Non spécifié',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          logement['adresse'] ?? 'Non spécifiée',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          '${logement['capacite'] ?? 'Non spécifiée'} personnes',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          '${logement['prix'] ?? 'Non spécifié'} FCFA/nuit',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.check_box, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          logement['equipements'] ?? 'Aucun',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          logement['disponibilites'] ?? 'Non spécifiées',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}