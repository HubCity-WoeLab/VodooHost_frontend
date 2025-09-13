import 'package:flutter/material.dart';
import 'property_detail.dart';

class SearchResultsPage extends StatefulWidget {
  final Map<String, dynamic> searchData;

  const SearchResultsPage({super.key, required this.searchData});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<Map<String, dynamic>> _generateAccommodations() {
    final String destination = widget.searchData['destination'] ?? 'Cotonou';

    // Base des logements par ville
    final Map<String, List<Map<String, dynamic>>> accommodationsByCity = {
      'Cotonou': [
        {
          'image': 'assets/images/111.jpeg',
          'title': 'Villa moderne avec piscine',
          'location': 'Cotonou, Benin',
          'distance': '2.5 km du centre',
          'price': '45 000 CFA',
          'rating': 4.8,
          'reviews': 42,
          'capacity': 6,
        },
        {
          'image': 'assets/images/222.avif',
          'title': 'Appartement climatisé',
          'location': 'Cotonou, Benin',
          'distance': '1.2 km du centre',
          'price': '30 000 CFA',
          'rating': 4.5,
          'reviews': 28,
          'capacity': 4,
        },
        {
          'image': 'assets/images/333.jpeg',
          'title': 'Maison traditionnelle rénovée',
          'location': 'Cotonou, Benin',
          'distance': '3.1 km du centre',
          'price': '25 000 CFA',
          'rating': 4.3,
          'reviews': 35,
          'capacity': 5,
        },
        {
          'image': 'assets/images/444.jpeg',
          'title': 'Studio moderne centre-ville',
          'location': 'Cotonou, Benin',
          'distance': '0.8 km du centre',
          'price': '20 000 CFA',
          'rating': 4.2,
          'reviews': 18,
          'capacity': 2,
        },
      ],
      'Ouidah': [
        {
          'image': 'assets/images/555.jpg',
          'title': 'Villa historique près de la plage',
          'location': 'Ouidah, Benin',
          'distance': '500m de la plage',
          'price': '55 000 CFA',
          'rating': 4.9,
          'reviews': 67,
          'capacity': 8,
        },
        {
          'image': 'assets/images/666.jpeg',
          'title': 'Maison coloniale authentique',
          'location': 'Ouidah, Benin',
          'distance': '1.5 km du centre historique',
          'price': '40 000 CFA',
          'rating': 4.7,
          'reviews': 45,
          'capacity': 6,
        },
        {
          'image': 'assets/images/777.jpeg',
          'title': 'Bungalow avec jardin tropical',
          'location': 'Ouidah, Benin',
          'distance': '2 km de la plage',
          'price': '35 000 CFA',
          'rating': 4.6,
          'reviews': 32,
          'capacity': 4,
        },
        {
          'image': 'assets/images/888.avif',
          'title': 'Chambre d\'hôtes familiale',
          'location': 'Ouidah, Benin',
          'distance': '1 km du centre',
          'price': '22 000 CFA',
          'rating': 4.4,
          'reviews': 29,
          'capacity': 3,
        },
      ],
      'Porto Novo': [
        {
          'image': 'assets/images/9999.jpeg',
          'title': 'Résidence présidentielle moderne',
          'location': 'Porto Novo, Benin',
          'distance': '1 km du palais présidentiel',
          'price': '50 000 CFA',
          'rating': 4.8,
          'reviews': 38,
          'capacity': 7,
        },
        {
          'image': 'assets/images/1111.jpeg',
          'title': 'Appartement vue lagune',
          'location': 'Porto Novo, Benin',
          'distance': '500m de la lagune',
          'price': '38 000 CFA',
          'rating': 4.6,
          'reviews': 41,
          'capacity': 5,
        },
        {
          'image': 'assets/images/2222.jpeg',
          'title': 'Maison traditionnelle Yoruba',
          'location': 'Porto Novo, Benin',
          'distance': '2 km du centre',
          'price': '28 000 CFA',
          'rating': 4.5,
          'reviews': 26,
          'capacity': 4,
        },
        {
          'image': 'assets/images/3333.jpeg',
          'title': 'Studio étudiant confortable',
          'location': 'Porto Novo, Benin',
          'distance': '1.5 km de l\'université',
          'price': '18 000 CFA',
          'rating': 4.1,
          'reviews': 15,
          'capacity': 2,
        },
      ],
      'Parakou': [
        {
          'image': 'assets/images/4444.jpeg',
          'title': 'Villa avec terrasse panoramique',
          'location': 'Parakou, Benin',
          'distance': '1.8 km du centre',
          'price': '42 000 CFA',
          'rating': 4.7,
          'reviews': 31,
          'capacity': 6,
        },
        {
          'image': 'assets/images/5555.avif',
          'title': 'Maison d\'hôtes accueillante',
          'location': 'Parakou, Benin',
          'distance': '2.5 km du marché',
          'price': '32 000 CFA',
          'rating': 4.4,
          'reviews': 22,
          'capacity': 5,
        },
        {
          'image': 'assets/images/6666.jpeg',
          'title': 'Appartement familial spacieux',
          'location': 'Parakou, Benin',
          'distance': '1.2 km du centre',
          'price': '26 000 CFA',
          'rating': 4.3,
          'reviews': 19,
          'capacity': 4,
        },
        {
          'image': 'assets/images/7777.jpeg',
          'title': 'Chambre simple et propre',
          'location': 'Parakou, Benin',
          'distance': '3 km du centre',
          'price': '15 000 CFA',
          'rating': 4.0,
          'reviews': 12,
          'capacity': 2,
        },
      ],
      'Abomey': [
        {
          'image': 'assets/images/8888.avif',
          'title': 'Palais royal restauré',
          'location': 'Abomey, Benin',
          'distance': '300m des palais royaux',
          'price': '60 000 CFA',
          'rating': 4.9,
          'reviews': 78,
          'capacity': 10,
        },
        {
          'image': 'assets/images/9999999.avif',
          'title': 'Maison d\'artisan authentique',
          'location': 'Abomey, Benin',
          'distance': '1 km du musée',
          'price': '35 000 CFA',
          'rating': 4.6,
          'reviews': 44,
          'capacity': 5,
        },
        {
          'image': 'assets/images/000000.avif',
          'title': 'Villa confortable et moderne',
          'location': 'Abomey, Benin',
          'distance': '2 km du centre historique',
          'price': '30 000 CFA',
          'rating': 4.4,
          'reviews': 33,
          'capacity': 6,
        },
        {
          'image': 'assets/images/111111.jpeg',
          'title': 'Gîte rural traditionnel',
          'location': 'Abomey, Benin',
          'distance': '4 km du centre',
          'price': '20 000 CFA',
          'rating': 4.2,
          'reviews': 21,
          'capacity': 3,
        },
      ],
    };

    return accommodationsByCity[destination] ??
        accommodationsByCity['Cotonou']!;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day}/${date.month}";
  }

  String _getDateRange() {
    final selectedDay = widget.searchData['selectedDay'] as DateTime?;
    final endDay = widget.searchData['endDay'] as DateTime?;

    if (selectedDay == null) return "Dates flexibles";

    if (endDay != null) {
      return "${_formatDate(selectedDay)} - ${_formatDate(endDay)}";
    } else {
      return _formatDate(selectedDay);
    }
  }

  int _getTotalGuests() {
    final adults = widget.searchData['adults'] ?? 0;
    final children = widget.searchData['children'] ?? 0;
    final infants = widget.searchData['infants'] ?? 0;
    return adults + children + infants;
  }

  @override
  Widget build(BuildContext context) {
    final accommodations = _generateAccommodations();
    final totalGuests = _getTotalGuests();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header avec informations de recherche
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Navigation
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.brown),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          "${accommodations.length} logements disponibles",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.brown,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Résumé de la recherche
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.brown.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.searchData['destination'] ??
                                    'Destination',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                              Text(
                                _getDateRange(),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "$totalGuests voyageur${totalGuests > 1 ? 's' : ''}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Liste des logements
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: accommodations.length,
                itemBuilder: (context, index) {
                  final accommodation = accommodations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildAccommodationCard(accommodation),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccommodationCard(Map<String, dynamic> accommodation) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PropertyDetailPage(
                  property: {
                    'image': accommodation['image'],
                    'location': accommodation['location'],
                    'distance': accommodation['distance'],
                    'dates': _getDateRange(),
                    'price': accommodation['price'],
                    'rating': accommodation['rating'],
                    'reviews': accommodation['reviews'],
                  },
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec bouton favori
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    accommodation['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.home,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),

            // Informations du logement
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accommodation['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    accommodation['location'],
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  Text(
                    accommodation['distance'],
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getDateRange(),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${accommodation['price']}/nuit",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.brown, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${accommodation['rating']} (${accommodation['reviews']})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.brown,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Jusqu'à ${accommodation['capacity']} voyageurs",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
