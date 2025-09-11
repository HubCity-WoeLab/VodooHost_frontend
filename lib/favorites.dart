import 'package:flutter/material.dart';

class FavorisPage extends StatelessWidget {
  const FavorisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Favoris",
          style: TextStyle(
            color: Color(0xFF6D2C2C), // Marron/rouge foncé
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _favorisItem(
              imagePath: "assets/images/logement.png",
              title: "Ouidah",
              date: "1 Jan - 15 Jan 2025",
            ),
          ],
        ),
      ),
    );
  }

  Widget _favorisItem({
    required String imagePath,
    required String title,
    required String date,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Texte (Ville + Date)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Icônes
            IconButton(
              onPressed: () {
                // Action partage
              },
              icon: const Icon(Icons.share, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                // Action supprimer
              },
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
