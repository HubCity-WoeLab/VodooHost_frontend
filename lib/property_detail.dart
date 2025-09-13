import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'about_place.dart';
import 'image_viewer.dart';
import 'all_reviews.dart';
import 'availability.dart';
import 'terms_conditions.dart';
import 'report_property.dart';
import 'payment_method.dart';
import 'reservation.dart';
import 'services/favorites_service.dart';

class PropertyDetailPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyDetailPage({super.key, required this.property});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  final MapController _mapController = MapController();
  late LatLng _propertyLocation;
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _initFavorites();
    // Coordonnées approximatives selon la ville
    _propertyLocation = _getCityCoordinates(
      widget.property['location'] ?? 'Cotonou, Benin',
    );
  }

  void _initFavorites() async {
    await _favoritesService.init();
    _favoritesService.onFavoritesChanged = () {
      if (mounted) setState(() {});
    };
  }

  LatLng _getCityCoordinates(String location) {
    // Coordonnées des villes du Bénin
    if (location.contains('Ouidah')) {
      return LatLng(6.3578, 2.0852);
    } else if (location.contains('Porto-Novo')) {
      return LatLng(6.4969, 2.6283);
    } else if (location.contains('Abomey')) {
      return LatLng(7.1826, 1.9971);
    } else if (location.contains('Parakou')) {
      return LatLng(9.3371, 2.6303);
    } else {
      // Cotonou par défaut
      return LatLng(6.4023, 2.5058);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE PRINCIPALE
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ImageViewerPage(
                              imageUrl:
                                  widget.property['image'] ??
                                  "assets/images/logement.png",
                              propertyTitle:
                                  widget.property['location'] ??
                                  "Villa privée à Ouidah",
                            ),
                      ),
                    );
                  },
                  child: Hero(
                    tag:
                        widget.property['image'] ??
                        "assets/images/logement.png",
                    child: Image.asset(
                      widget.property['image'] ?? "assets/images/logement.png",
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.brown),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        _favoritesService.isFavorite(widget.property)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await _favoritesService.toggleFavorite(widget.property);
                        setState(() {});

                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _favoritesService.isFavorite(widget.property)
                                  ? 'Ajouté aux favoris'
                                  : 'Retiré des favoris',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // TITRE + INFOS
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.property['location'] ??
                        "Villa privée à Ouidah à proximité de la gare routière",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.brown, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.property['rating'] ?? 4.9} · ${widget.property['reviews'] ?? 32} avis",
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.brown.shade100,
                        child: const Icon(Icons.person, color: Colors.brown),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Chambre privée hébergée par Colwen",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // POINTS CLÉS
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.vpn_key, color: Colors.brown),
                    title: Text("Arrivée autonome"),
                    subtitle: Text(
                      "Vous pouvez faire votre arrivée avec le digicode.",
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    leading: Icon(Icons.place, color: Colors.brown),
                    title: Text("Excellent emplacement"),
                    subtitle: Text(
                      "95% des voyageurs récents ont attribué 5 étoiles à l'emplacement.",
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    leading: Icon(Icons.event_available, color: Colors.brown),
                    title: Text("Annulation gratuite"),
                    subtitle: Text("Avant le 25 juin."),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // EXPÉRIENCE À VIVRE
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Expérience à vivre",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Profitez d'une chambre privée avec un lit double confortable, "
                    "un espace de travail et une salle de bain moderne. "
                    "Parfait pour un séjour relaxant et paisible à Ouidah. "
                    "L'emplacement est idéal pour découvrir l'histoire et la culture du Bénin...",

                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPlacePage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Voir plus",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, color: Colors.grey),

            // CHAMBRE
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Où vous dormirez",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.bed, color: Colors.brown, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "1 chambre · 1 lit queen",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // SERVICES ET ÉQUIPEMENTS
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ce que propose cet endroit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAmenityChip("Vue sur la végétation", Icons.nature),
                      _buildAmenityChip("Cuisine", Icons.kitchen),
                      _buildAmenityChip("Wifi", Icons.wifi),
                      _buildAmenityChip("Parking gratuit", Icons.local_parking),
                      _buildAmenityChip("Climatisation", Icons.ac_unit),
                      _buildAmenityChip("Eau chaude", Icons.water_drop),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // LOCALISATION AVEC CARTE
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Où vous serez",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _propertyLocation,
                          initialZoom: 13.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.vodoohost.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 40.0,
                                height: 40.0,
                                point: _propertyLocation,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          // Attribution obligatoire pour OpenStreetMap
                          const RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                '© OpenStreetMap contributors',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.property['location'] ?? "Ouidah, Benin, Afrique",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // AVIS
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.brown),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.property['rating'] ?? 4.95} · ${widget.property['reviews'] ?? 22} avis",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildReviewTile(
                    "Emma",
                    "Excellent emplacement ! Avec la climatisation et proximité de la gare.",
                  ),
                  const SizedBox(height: 12),
                  _buildReviewTile(
                    "Jean",
                    "Très propre et accueillant. Je recommande vivement!",
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  AllReviewsPage(property: widget.property),
                        ),
                      );
                    },
                    child: const Text(
                      "Voir tous les avis",
                      style: TextStyle(color: Colors.brown, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // DISPONIBILITÉ
            ListTile(
              title: const Text(
                "Disponibilité",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text(widget.property['dates'] ?? "08 – 20 juin 2025"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.brown,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AvailabilityPage(property: widget.property),
                  ),
                );
              },
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // RÈGLES DE LA MAISON
            const ListTile(
              title: Text(
                "Règles de la maison",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text("Pas d'animaux · Non-fumeur · Pas de fêtes"),
              trailing: Icon(Icons.rule, color: Colors.brown),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // POLITIQUE D'ANNULATION
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Politique d'annulation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Annulez gratuitement avant le 1er janvier. "
                    "Ensuite, annulez avant l'arrivée et obtenez un remboursement de 50%.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => TermsConditionsPage(
                                property: widget.property,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "Voir les conditions complètes",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, color: Colors.grey),

            // SIGNALER L'ANNONCE
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Signaler cette annonce",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Vous avez remarqué un problème avec cette annonce ? "
                    "Signalez-le nous pour maintenir la qualité de notre plateforme.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ReportPropertyPage(property: widget.property),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: Colors.red.shade600,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Signaler cette annonce",
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Espace pour la barre du bas
          ],
        ),
      ),

      // BARRE DU BAS AVEC PRIX + RÉSERVER
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.property['price'] ?? '30,000'} CFA",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    "par nuit",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ReservationPage(property: widget.property),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Réserver",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmenityChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.brown),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildReviewTile(String name, String review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.brown.shade100,
            child: Text(
              name[0],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(review, style: const TextStyle(fontSize: 14, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
