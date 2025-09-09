import 'package:flutter/material.dart';

class Divinites extends StatelessWidget {
  const Divinites({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> divinites = [
      {
        'name': 'Mawu',
        'description': 'Déesse suprême de la création.',
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'Legba',
        'description': 'Divinité de la communication et des chemins.',
        'icon': Icons.swap_horiz,
      },
      {
        'name': 'Sakpata',
        'description': 'Divinité de la terre et de la guérison.',
        'icon': Icons.grass,
      },
      {
        'name': 'Heviosso',
        'description': 'Divinité du tonnerre et de la justice.',
        'icon': Icons.flash_on,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: divinites.length,
      itemBuilder: (context, index) {
        final divinite = divinites[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: ListTile(
            leading: Icon(
              divinite['icon'],
              size: 40.0,
              color: Color(0xFF852318),
            ),
            title: Text(
              divinite['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(divinite['description']),
          ),
        );
      },
    );
  }
}