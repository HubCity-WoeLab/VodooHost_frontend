import 'package:flutter/material.dart';
import 'services/favorites_service.dart';
import 'property_detail.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _initFavorites();
  }

  void _initFavorites() async {
    await _favoritesService.init();
    _favoritesService.onFavoritesChanged = () {
      if (mounted) setState(() {});
    };
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favoris (${_favoritesService.favoritesCount})",
          style: const TextStyle(
            color: Color(0xFF6D2C2C), // Marron/rouge foncé
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          if (_favoritesService.favoritesCount > 0)
            IconButton(
              icon: const Icon(Icons.clear_all, color: Color(0xFF6D2C2C)),
              onPressed: () {
                _showClearAllDialog(context);
              },
            ),
        ],
      ),
      body:
          _favoritesService.favorites.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: _favoritesService.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = _favoritesService.favorites[index];
                  return _favorisItem(property: favorite, context: context);
                },
              ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aucun favori pour le moment',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Appuyez sur ❤️ sur une propriété\npour l\'ajouter à vos favoris',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer tous les favoris'),
          content: const Text(
            'Êtes-vous sûr de vouloir supprimer tous vos favoris ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _favoritesService.clearAllFavorites();
                Navigator.pop(context);
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _favorisItem({
    required Map<String, dynamic> property,
    required BuildContext context,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigation vers les détails de la propriété
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailPage(property: property),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  property['image'] ?? "assets/images/logement.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Informations de la propriété
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property['location'] ?? 'Lieu non spécifié',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property['distance'] ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      property['dates'] ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      property['price'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6D2C2C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF6D2C2C),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${property['rating'] ?? 0} (${property['reviews'] ?? 0})",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6D2C2C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Action partage
                      _shareProperty(property);
                    },
                    icon: const Icon(Icons.share, color: Colors.grey, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      // Action supprimer des favoris
                      _removeFavorite(property);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareProperty(Map<String, dynamic> property) {
    // Logique de partage (à implémenter selon les besoins)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Partage de ${property['location']} (fonctionnalité à venir)',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFavorite(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer des favoris'),
          content: Text(
            'Voulez-vous supprimer "${property['location']}" de vos favoris ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                await _favoritesService.removeFromFavorites(property);
                Navigator.pop(context);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Supprimé des favoris'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
