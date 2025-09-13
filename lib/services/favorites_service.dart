import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'user_favorites';

  // Singleton pattern
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  // Liste des favoris en mémoire
  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> get favorites => _favorites;

  // Callback pour notifier les changements
  Function()? onFavoritesChanged;

  // Initialiser le service (charger les favoris depuis les préférences)
  Future<void> init() async {
    await _loadFavorites();
  }

  // Charger les favoris depuis SharedPreferences
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_favoritesKey);

      if (favoritesJson != null) {
        final List<dynamic> favoritesList = jsonDecode(favoritesJson);
        _favorites = favoritesList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Erreur lors du chargement des favoris: $e');
      _favorites = [];
    }
  }

  // Sauvegarder les favoris dans SharedPreferences
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String favoritesJson = jsonEncode(_favorites);
      await prefs.setString(_favoritesKey, favoritesJson);
    } catch (e) {
      print('Erreur lors de la sauvegarde des favoris: $e');
    }
  }

  // Ajouter une propriété aux favoris
  Future<void> addToFavorites(Map<String, dynamic> property) async {
    // Vérifier si la propriété n'est pas déjà dans les favoris
    if (!isFavorite(property)) {
      // Ajouter un ID unique basé sur l'image et la location
      final favoriteProperty = Map<String, dynamic>.from(property);
      favoriteProperty['favoriteId'] =
          '${property['image']}_${property['location']}';
      favoriteProperty['dateAdded'] = DateTime.now().toIso8601String();

      _favorites.add(favoriteProperty);
      await _saveFavorites();

      // Notifier les listeners
      onFavoritesChanged?.call();
    }
  }

  // Supprimer une propriété des favoris
  Future<void> removeFromFavorites(Map<String, dynamic> property) async {
    final favoriteId = '${property['image']}_${property['location']}';

    _favorites.removeWhere((fav) => fav['favoriteId'] == favoriteId);
    await _saveFavorites();

    // Notifier les listeners
    onFavoritesChanged?.call();
  }

  // Vérifier si une propriété est dans les favoris
  bool isFavorite(Map<String, dynamic> property) {
    final favoriteId = '${property['image']}_${property['location']}';
    return _favorites.any((fav) => fav['favoriteId'] == favoriteId);
  }

  // Toggle le statut favori d'une propriété
  Future<void> toggleFavorite(Map<String, dynamic> property) async {
    if (isFavorite(property)) {
      await removeFromFavorites(property);
    } else {
      await addToFavorites(property);
    }
  }

  // Obtenir le nombre de favoris
  int get favoritesCount => _favorites.length;

  // Vider tous les favoris
  Future<void> clearAllFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    onFavoritesChanged?.call();
  }
}
