import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

  // Variables pour stocker l'état actuel de la carte
  LatLng _currentCenter = LatLng(6.3654, 2.4183);
  double _currentZoom = 13.0;

  // Liste des propriétés avec leurs coordonnées
  final List<PropertyMarker> properties = [
    PropertyMarker(
      position: LatLng(6.3654, 2.4183), // Ouidah, Benin
      title: "Villa Luxueuse Ouidah",
      price: "49,000 CFA/nuit",
      rating: 4.8,
      image: "assets/images/111.jpeg",
    ),
    PropertyMarker(
      position: LatLng(6.3704, 2.4233),
      title: "Maison Traditionnelle",
      price: "29,000 CFA/nuit",
      rating: 4.5,
      image: "assets/images/222.avif",
    ),
    PropertyMarker(
      position: LatLng(6.3584, 2.4133),
      title: "Chambre Confortable",
      price: "23,000 CFA/nuit",
      rating: 4.2,
      image: "assets/images/333.jpeg",
    ),
    PropertyMarker(
      position: LatLng(6.3724, 2.4283),
      title: "Cabane Écologique",
      price: "39,000 CFA/nuit",
      rating: 4.9,
      image: "assets/images/444.jpeg",
    ),
  ];

  PropertyMarker? selectedProperty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carte
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(6.3654, 2.4183), // Centré sur Ouidah
              initialZoom: 13.0,
              minZoom: 10.0,
              maxZoom: 18.0,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedProperty = null;
                });
              },
            ),
            children: [
              // Couche de tuiles OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.vodoohost.app',
                maxZoom: 19,
              ),

              // Marqueurs des propriétés
              MarkerLayer(
                markers:
                    properties.map((property) {
                      final isSelected = selectedProperty == property;
                      return Marker(
                        point: property.position,
                        width: isSelected ? 120 : 80,
                        height: isSelected ? 60 : 40,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedProperty = property;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.brown : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.brown
                                        : Colors.grey.shade300,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                property.price,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSelected ? 14 : 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),

          // Header avec barre de recherche
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.brown),
                    ),
                    Expanded(
                      child: Text(
                        "Ouidah, Benin • 08-11 Jan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Action de filtre
                      },
                      icon: const Icon(Icons.tune, color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Boutons de contrôle de la carte
          Positioned(
            right: 16,
            bottom: selectedProperty != null ? 200 : 100,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentZoom = (_currentZoom + 1).clamp(10.0, 18.0);
                    });
                    _mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.add, color: Colors.brown),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentZoom = (_currentZoom - 1).clamp(10.0, 18.0);
                    });
                    _mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.remove, color: Colors.brown),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _currentCenter = LatLng(6.3654, 2.4183);
                      _currentZoom = 13.0;
                    });
                    _mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.my_location, color: Colors.brown),
                ),
              ],
            ),
          ),

          // Bouton de liste
          Positioned(
            bottom: selectedProperty != null ? 200 : 100,
            left: 16,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.brown,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.list, color: Colors.white),
              label: const Text("Liste", style: TextStyle(color: Colors.white)),
            ),
          ),

          // Carte de la propriété sélectionnée
          if (selectedProperty != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        child: Image.asset(
                          selectedProperty!.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Informations
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProperty!.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      selectedProperty!.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedProperty!.price,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Voir",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PropertyMarker {
  final LatLng position;
  final String title;
  final String price;
  final double rating;
  final String image;

  PropertyMarker({
    required this.position,
    required this.title,
    required this.price,
    required this.rating,
    required this.image,
  });
}
