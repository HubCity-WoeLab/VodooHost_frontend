import 'package:flutter/material.dart';
import 'experience_detail.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          // --- Titre principal ---
          const Text(
            "Voyages",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B2E2E), // marron foncé
            ),
          ),
          const SizedBox(height: 20),

          // --- Section réservations ---
          const Text(
            "Réservations à venir",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildReservationCard(),

          const SizedBox(height: 24),

          // --- Section expériences ---
          const Text(
            "Découvrez les expériences à vivre à Ouidah",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          _buildExperiencesList(context),
        ],
      ),
    );
  }

  /// --- Carte réservation ---
  Widget _buildReservationCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/9999999.avif",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B2E2E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "En attente",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          // Infos séjour
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ouidah",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Chambre privée chez Hougno",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Jan\n08 - 11\n2025",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Ouidah, Benin, Afrique",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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
  }

  /// --- Liste expériences ---
  Widget _buildExperiencesList(BuildContext context) {
    final experiences = [
      {
        "title": "Juste pour toi",
        "subtitle": "06 expériences",
        "image": "assets/images/danse.jpg",
      },
      {
        "title": "Culture & Histoire",
        "subtitle": "04 expériences",
        "image": "assets/images/logement.png",
      },
      {
        "title": "Hébergements",
        "subtitle": "08 expériences",
        "image": "assets/images/33333.jpg",
      },
      {
        "title": "Découvertes",
        "subtitle": "05 expériences",
        "image": "assets/images/555.jpg",
      },
    ];

    return Column(
      children:
          experiences.map((exp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildExperienceCard(
                context,
                exp["title"]!,
                exp["subtitle"]!,
                exp["image"]!,
              ),
            );
          }).toList(),
    );
  }

  /// --- Carte Expérience ---
  Widget _buildExperienceCard(
    BuildContext context,
    String title,
    String subtitle,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ExperienceDetailPage(
                  experience: {
                    'title': title,
                    'subtitle': subtitle,
                    'image': image,
                  },
                ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
