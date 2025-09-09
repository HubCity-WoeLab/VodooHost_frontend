import 'package:flutter/material.dart';

class Rituels extends StatelessWidget {
  const Rituels({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple de données pour les rituels
    final List<Map<String, dynamic>> rituels = [
      {
        'nom': 'Rituel de purification',
        'description': 'Un rituel pour purifier l\'esprit et le corps.',
        'logement': 'Maison sacrée',
        'divinite': 'Mawu',
        'calendrier': ['2024-01-01', '2024-01-15'],
      },
      {
        'nom': 'Rituel de prospérité',
        'description': 'Un rituel pour attirer la richesse et la chance.',
        'logement': 'Temple de Legba',
        'divinite': 'Legba',
        'calendrier': ['2024-02-10', '2024-02-20'],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: rituels.length,
      itemBuilder: (context, index) {
        final rituel = rituels[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: ListTile(
            leading: Icon(
              Icons.local_fire_department, // Icon representing "Rituels"
              size: 40.0,
              color: Color(0xFF852318),
            ),
            title: Text(
              rituel['nom'],
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(
                  rituel['description'] ?? 'Aucune description disponible.',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Logement : ${rituel['logement']}',
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                Text(
                  'Divinité : ${rituel['divinite']}',
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Calendrier : ${rituel['calendrier'].join(', ')}',
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}