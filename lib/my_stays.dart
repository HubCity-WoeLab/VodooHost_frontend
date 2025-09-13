import 'package:flutter/material.dart';

class MyStaysPage extends StatefulWidget {
  const MyStaysPage({Key? key}) : super(key: key);

  @override
  State<MyStaysPage> createState() => _MyStaysPageState();
}

class _MyStaysPageState extends State<MyStaysPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF884B4B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Mes Séjours",
          style: TextStyle(
            color: Color(0xFF884B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF884B4B),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF884B4B),
          tabs: const [
            Tab(text: "En cours"),
            Tab(text: "Terminés"),
            Tab(text: "Annulés"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStaysList("current"),
          _buildStaysList("completed"),
          _buildStaysList("cancelled"),
        ],
      ),
    );
  }

  Widget _buildStaysList(String type) {
    List<Map<String, dynamic>> stays = _getStaysForType(type);

    if (stays.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hotel_outlined, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              _getEmptyMessage(type),
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stays.length,
      itemBuilder: (context, index) {
        return _buildStayCard(stays[index], type);
      },
    );
  }

  Widget _buildStayCard(Map<String, dynamic> stay, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image et statut
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  stay['image'],
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(type),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(type),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom et lieu
                Text(
                  stay['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF884B4B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      stay['location'],
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Dates
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Color(0xFF884B4B),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${stay['checkIn']} - ${stay['checkOut']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Invités et prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 16,
                          color: Color(0xFF884B4B),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${stay['guests']} invités",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      "${stay['price']} FCFA",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF884B4B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Boutons d'action
                Row(
                  children: [
                    if (type == "current") ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showCancelDialog(context, stay),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Annuler",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _viewDetails(stay),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF884B4B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          type == "current"
                              ? "Détails"
                              : type == "completed"
                              ? "Revoir"
                              : "Voir",
                        ),
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

  List<Map<String, dynamic>> _getStaysForType(String type) {
    switch (type) {
      case "current":
        return [
          {
            'name': 'Villa Luxueuse Ouidah',
            'location': 'Ouidah, Bénin',
            'image': 'assets/images/111.jpeg',
            'checkIn': '25 Avr 2025',
            'checkOut': '27 Avr 2025',
            'guests': 3,
            'price': '60000',
          },
        ];
      case "completed":
        return [
          {
            'name': 'Appartement Centre-Ville',
            'location': 'Cotonou, Bénin',
            'image': 'assets/images/222.avif',
            'checkIn': '15 Mar 2025',
            'checkOut': '18 Mar 2025',
            'guests': 2,
            'price': '45000',
          },
          {
            'name': 'Maison Traditionnelle',
            'location': 'Abomey, Bénin',
            'image': 'assets/images/333.jpeg',
            'checkIn': '10 Feb 2025',
            'checkOut': '12 Feb 2025',
            'guests': 4,
            'price': '35000',
          },
        ];
      case "cancelled":
        return [
          {
            'name': 'Resort Plage',
            'location': 'Grand-Popo, Bénin',
            'image': 'assets/images/444.jpeg',
            'checkIn': '5 Jan 2025',
            'checkOut': '8 Jan 2025',
            'guests': 2,
            'price': '80000',
          },
        ];
      default:
        return [];
    }
  }

  Color _getStatusColor(String type) {
    switch (type) {
      case "current":
        return Colors.green;
      case "completed":
        return const Color(0xFF884B4B);
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String type) {
    switch (type) {
      case "current":
        return "En cours";
      case "completed":
        return "Terminé";
      case "cancelled":
        return "Annulé";
      default:
        return "";
    }
  }

  String _getEmptyMessage(String type) {
    switch (type) {
      case "current":
        return "Vous n'avez aucun séjour en cours.\nRéservez votre prochain voyage !";
      case "completed":
        return "Aucun séjour terminé.\nVos séjours passés apparaîtront ici.";
      case "cancelled":
        return "Aucun séjour annulé.\nTant mieux !";
      default:
        return "";
    }
  }

  void _viewDetails(Map<String, dynamic> stay) {
    // TODO: Implémenter la navigation vers les détails du séjour
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Affichage des détails de ${stay['name']}"),
        backgroundColor: const Color(0xFF884B4B),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, Map<String, dynamic> stay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Annuler la réservation",
            style: TextStyle(
              color: Color(0xFF884B4B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Êtes-vous sûr de vouloir annuler votre réservation pour ${stay['name']} ?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Non", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Réservation annulée avec succès"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Oui, annuler"),
            ),
          ],
        );
      },
    );
  }
}
