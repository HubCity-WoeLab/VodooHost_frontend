import 'package:flutter/material.dart';
import 'widget/constants.dart';

class Divinites extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddDivinite;

  const Divinites({super.key, required this.onAddDivinite});

  @override
  State<Divinites> createState() => _DivinitesState();
}

class _DivinitesState extends State<Divinites> {
  final List<Map<String, dynamic>> divinites = [
    {'name': 'Mawu', 'icon': Icons.wb_sunny},
    {'name': 'Legba', 'icon': Icons.swap_horiz},
    {'name': 'Sakpata', 'icon': Icons.grass},
    {'name': 'Heviosso', 'icon': Icons.flash_on},
    {'name': 'Agbe', 'icon': Icons.water},
    {'name': 'Gu', 'icon': Icons.shield},
    {'name': 'Dan', 'icon': Icons.all_inclusive},
    {'name': 'Aido-Hwedo', 'icon': Icons.drag_handle},
    {'name': 'Loko', 'icon': Icons.nature},
    {'name': 'Ayizan', 'icon': Icons.local_florist},
  ];

  String? _selectedDivinite;
  final TextEditingController _descriptionController = TextEditingController();

  void _submitDivinite() {
    if (_selectedDivinite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une divinité.')),
      );
      return;
    }

    final divinite = {
      'nom': _selectedDivinite,
      'description': _descriptionController.text,
    };

    widget.onAddDivinite(divinite);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Divinité ajoutée avec succès !')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Divinité'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vous êtes adepte de quelle divinité ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: divinites.length,
                itemBuilder: (context, index) {
                  final divinite = divinites[index];
                  return ListTile(
                    leading: Icon(divinite['icon'], color: AppColors.secondaryRed),                    title: Text(divinite['name']),
                    onTap: () {
                      setState(() {
                        _selectedDivinite = divinite['name'];
                      });
                    },
                    selected: _selectedDivinite == divinite['name'],
                    selectedTileColor: AppColors.secondaryLight,
                  );
                },
              ),
            ),
            if (_selectedDivinite != null) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optionnelle)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitDivinite,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                ),
                child: const Text('Ajouter'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}