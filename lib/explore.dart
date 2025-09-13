import 'package:flutter/material.dart';
import 'search.dart';
import 'map_page.dart';
import 'property_detail.dart';
import 'services/favorites_service.dart';

class RealEstatePage extends StatefulWidget {
  const RealEstatePage({super.key});

  @override
  State<RealEstatePage> createState() => _RealEstatePageState();
}

class _RealEstatePageState extends State<RealEstatePage> {
  int selectedCategory = 0;
  final List<String> categories = ["Maison", "Chambre", "Cabane"];
  final List<IconData> categoryIcons = [Icons.home, Icons.bed, Icons.cabin];
  String selectedCity = "Où voulez-vous aller ?";
  String selectedDateInfo = "Quand · Avec qui";
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DestinationPage(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              if (result is String) {
                                // Ancien comportement - juste une ville
                                selectedCity = result;
                              } else if (result is Map<String, dynamic>) {
                                // Nouveau comportement - ville + date
                                selectedCity = result['destination'];
                                if (result['selectedDay'] != null) {
                                  DateTime selectedDay = result['selectedDay'];
                                  selectedDateInfo =
                                      "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}";
                                }
                              }
                            });
                          }
                        },
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText:
                                selectedCity == "Où voulez-vous aller ?"
                                    ? "Où voulez-vous aller ?\nOù · Quand · Avec qui"
                                    : "$selectedCity\n$selectedDateInfo · Avec qui",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  selectedCity == "Où voulez-vous aller ?"
                                      ? Colors.grey
                                      : Colors.brown,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.brown,
                            ),
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Action pour le filtre
                        },
                        icon: const Icon(
                          Icons.tune,
                          color: Colors.brown,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Catégories
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    categories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final category = entry.value;
                      final isSelected = selectedCategory == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categoryIcons[index],
                              size: 24,
                              color:
                                  isSelected
                                      ? (index == 0
                                          ? Colors.brown
                                          : Colors.orange)
                                      : (index == 0
                                          ? Colors.grey
                                          : Colors.orange),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color:
                                    isSelected
                                        ? (index == 0
                                            ? Colors.brown
                                            : Colors.orange)
                                        : (index == 0
                                            ? Colors.grey
                                            : Colors.orange),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 30,
                                color:
                                    index == 0 ? Colors.brown : Colors.orange,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Liste des logements
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _buildListingCard(
                    image: "assets/images/logement.png",
                    location: "Ouidah, Benin",
                    distance: "1,669 kilometers",
                    dates: "31 dec – 31 jan",
                    price: "50 000 Fcfa/jour",
                    rating: 4.87,
                    reviews: 71,
                  ),
                  const SizedBox(height: 15),
                  _buildListingCard(
                    image: "assets/images/logement.png",
                    location: "Cotonou, Benin",
                    distance: "2,050 kilometers",
                    dates: "5 jan – 15 jan",
                    price: "35 000 Fcfa/jour",
                    rating: 4.65,
                    reviews: 54,
                  ),
                  const SizedBox(height: 15),
                  _buildListingCard(
                    image: "assets/images/33333.jpg",
                    location: "Porto-Novo, Benin",
                    distance: "1,850 kilometers",
                    dates: "15 jan – 20 jan",
                    price: "45 000 Fcfa/jour",
                    rating: 4.92,
                    reviews: 28,
                  ),
                  const SizedBox(height: 15),
                  _buildListingCard(
                    image: "assets/images/555.jpg",
                    location: "Abomey, Benin",
                    distance: "1,750 kilometers",
                    dates: "25 jan – 30 jan",
                    price: "40 000 Fcfa/jour",
                    rating: 4.73,
                    reviews: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bouton flottant "Map"
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapPage()),
          );
        },
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.map, color: Colors.white),
        label: const Text("Map", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Widget carte logement
  Widget _buildListingCard({
    required String image,
    required String location,
    required String distance,
    required String dates,
    required String price,
    required double rating,
    required int reviews,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PropertyDetailPage(
                  property: {
                    'image': image,
                    'location': location,
                    'distance': distance,
                    'dates': dates,
                    'price': price,
                    'rating': rating,
                    'reviews': reviews,
                  },
                ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec bouton favori
            Stack(
              children: [
                Image.asset(
                  image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        _favoritesService.isFavorite({
                              'image': image,
                              'location': location,
                              'distance': distance,
                              'dates': dates,
                              'price': price,
                              'rating': rating,
                              'reviews': reviews,
                            })
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await _favoritesService.toggleFavorite({
                          'image': image,
                          'location': location,
                          'distance': distance,
                          'dates': dates,
                          'price': price,
                          'rating': rating,
                          'reviews': reviews,
                        });
                        setState(() {});

                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _favoritesService.isFavorite({
                                    'image': image,
                                    'location': location,
                                    'distance': distance,
                                    'dates': dates,
                                    'price': price,
                                    'rating': rating,
                                    'reviews': reviews,
                                  })
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

            // Infos logement
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(distance, style: const TextStyle(color: Colors.grey)),
                  Text(dates, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.brown, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "$rating ($reviews)",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.brown,
                        ),
                      ),
                    ],
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
