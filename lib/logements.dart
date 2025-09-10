import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widget/constants.dart';


class Logements extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddLogement;

  const Logements({super.key, required this.onAddLogement});

  @override
  State<Logements> createState() => _LogementsState();
}

class _LogementsState extends State<Logements> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _logementData = {};
  final List<String> _selectedEquipments = [];
  final List<File> _photos = [];
  String? _selectedLogementType;
  DateTimeRange? _selectedDateRange;

  final ImagePicker _picker = ImagePicker();


  Future<void> _submitLogement() async {
    final url = AppConstants.createLogement;

    // Ensure `prix_journalier` is a number
    if (_logementData['prix'] == null || double.tryParse(_logementData['prix']) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le prix doit être un nombre valide.')),
      );
      return;
    }

    // Update `_logementData` to match backend DTO
    _logementData['prix_journalier'] = double.parse(_logementData['prix']);
    _logementData.remove('prix'); // Remove temporary field
    _logementData['equipements'] = _selectedEquipments; // Ensure it's a list
    _logementData['disponibilites'] = _selectedDateRange != null
        ? [
      _selectedDateRange!.start.toIso8601String(),
      _selectedDateRange!.end.toIso8601String()
    ]
        : [];

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(_logementData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logement créé avec succès !')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partagez votre logement'),
        backgroundColor: const Color(0xFF852318),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (_currentStep == 3) {
                    if (_validateRequiredFields()) {
                      _showSummaryDialog(context);
                    }
                  } else {
                    setState(() {
                      _currentStep++;
                    });
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Informations de base'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nom du logement',
                            hintText: 'Exemple : Maison de charme à Cotonou',
                          ),
                          onSaved: (value) => _logementData['nom'] = value ?? '',
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Nom requis' : null,
                        ),
                        GestureDetector(
                          onTap: () => _showLogementTypeDialog(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedLogementType ?? 'Sélectionnez le type de logement',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Adresse',
                            hintText: 'Exemple : Quartier Haie Vive, Cotonou',
                          ),
                          onSaved: (value) => _logementData['adresse'] = value ?? '',
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Adresse requise' : null,
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: const Text('Détails'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Capacité',
                          hintText: 'Exemple : 4 personnes',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _logementData['capacite'] = value ?? '',
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Capacité requise' : null,
                      ),
                      GestureDetector(
                        onTap: () => _showEquipmentsDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedEquipments.isEmpty
                                    ? 'Sélectionnez les équipements'
                                    : _selectedEquipments.join(', '),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Décrivez votre logement en quelques mots',
                        ),
                        onSaved: (value) => _logementData['description'] = value ?? '',
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Description requise' : null,
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Prix et Disponibilités'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Prix par nuit (en FCFA)',
                          hintText: 'Exemple : 25000',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _logementData['prix'] = value ?? '',
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Prix requis' : null,
                      ),
                      GestureDetector(
                        onTap: () => _selectDateRange(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDateRange == null
                                    ? 'Sélectionnez les disponibilités'
                                    : 'Du ${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} au ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Photos'),
                  content: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImageFromCamera,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Prendre une photo'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickImageFromGallery,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Choisir depuis la galerie'),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _photos.map((photo) {
                          return Stack(
                            children: [
                              Image.file(
                                photo,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _photos.remove(photo);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _photos.add(File(pickedFile.path));
        _logementData['photos'] = _photos.map((photo) => photo.path).toList();
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photos.add(File(pickedFile.path));
        _logementData['photos'] = _photos.map((photo) => photo.path).toList();
      });
    }
  }

  bool _validateRequiredFields() {
    if (_photos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez ajouter au moins une photo.')),
      );
      return false;
    }
    return true;
  }

  void _showSummaryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('🎉 Résumé de votre logement'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🏠 Nom : ${_logementData['nom']}'),
                Text('📍 Adresse : ${_logementData['adresse']}'),
                Text('👥 Capacité : ${_logementData['capacite']} personnes'),
                Text('✨ Équipements : ${_selectedEquipments.join(", ")}'),
                Text('💬 Description : ${_logementData['description']}'),
                Text('💰 Prix : ${_logementData['prix']} FCFA/nuit'),
                Text(
                  '📅 Disponibilités : Du ${_selectedDateRange!.start.toLocal().toString().split(" ")[0]} au ${_selectedDateRange!.end.toLocal().toString().split(" ")[0]}',
                ),
                const SizedBox(height: 10),
                const Text('📷 Photos :'),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _photos.map((photo) {
                    return Image.file(
                      photo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _logementData['equipements'] = _selectedEquipments.join(", ");
                widget.onAddLogement(_logementData);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Publier'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
        _logementData['disponibilites'] =
        '${picked.start.toLocal().toString().split(" ")[0]} - ${picked.end.toLocal().toString().split(" ")[0]}';
      });
    }
  }

  void _showEquipmentsDialog(BuildContext context) {
    final List<Map<String, dynamic>> equipmentOptions = [
      {'name': 'Wi-Fi', 'icon': Icons.wifi},
      {'name': 'Parking', 'icon': Icons.local_parking},
      {'name': 'Climatisation', 'icon': Icons.ac_unit},
      {'name': 'Piscine', 'icon': Icons.pool},
      {'name': 'Sèche-cheveux', 'icon': Icons.bathroom},
      {'name': 'Shampoing', 'icon': Icons.soap},
      {'name': 'Eau chaude', 'icon': Icons.water},
      {'name': 'Gel douche', 'icon': Icons.shower},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sélectionnez les équipements'),
          content: SingleChildScrollView(
            child: Column(
              children: equipmentOptions.map((equipment) {
                return CheckboxListTile(
                  value: _selectedEquipments.contains(equipment['name']),
                  title: Row(
                    children: [
                      Icon(equipment['icon'], color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(equipment['name']),
                    ],
                  ),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected != null && isSelected) {
                        if (!_selectedEquipments.contains(equipment['name'])) {
                          _selectedEquipments.add(equipment['name']);
                        }
                      } else {
                        _selectedEquipments.remove(equipment['name']);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showLogementTypeDialog(BuildContext context) {
    final List<Map<String, dynamic>> logementTypes = [
      {'name': 'Maison traditionnelle', 'icon': Icons.home},
      {'name': 'Case', 'icon': Icons.cottage},
      {'name': 'Villa moderne', 'icon': Icons.villa},
      {'name': 'Appartement', 'icon': Icons.apartment},
      {'name': 'Studio', 'icon': Icons.meeting_room},
      {'name': 'Chambre d\'hôtes', 'icon': Icons.bed},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sélectionnez le type de logement'),
          content: SingleChildScrollView(
            child: Column(
              children: logementTypes.map((type) {
                return ListTile(
                  leading: Icon(type['icon'], color: Colors.grey),
                  title: Text(type['name']),
                  onTap: () {
                    setState(() {
                      _selectedLogementType = type['name'];
                      _logementData['type'] = type['name'];
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}