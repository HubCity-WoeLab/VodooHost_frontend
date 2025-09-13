import 'package:flutter/material.dart';
import 'services/favorites_service.dart';
import 'reservation.dart';

class ExperienceDetailPage extends StatefulWidget {
  final Map<String, dynamic> experience;

  const ExperienceDetailPage({super.key, required this.experience});

  @override
  State<ExperienceDetailPage> createState() => _ExperienceDetailPageState();
}

class _ExperienceDetailPageState extends State<ExperienceDetailPage> {
  final FavoritesService _favoritesService = FavoritesService();
  int _currentImageIndex = 0;

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

  List<String> _getExperienceImages(String category) {
    switch (category) {
      case "Juste pour toi":
        return [
          "assets/images/danse.jpg",
          "assets/images/777.jpeg",
          "assets/images/888.jpeg",
        ];
      case "Culture & Histoire":
        return [
          "assets/images/logement.png",
          "assets/images/33333.jpg",
          "assets/images/555.jpg",
        ];
      case "Hébergements":
        return [
          "assets/images/33333.jpg",
          "assets/images/555.jpg",
          "assets/images/logement.png",
        ];
      case "Découvertes":
        return [
          "assets/images/555.jpg",
          "assets/images/danse.jpg",
          "assets/images/33333.jpg",
        ];
      default:
        return ["assets/images/logement.png"];
    }
  }

  Map<String, dynamic> _getExperienceDetails(String category) {
    switch (category) {
      case "Juste pour toi":
        return {
          "description":
              "Des expériences personnalisées selon vos goûts et préférences. Découvrez Ouidah à travers des activités uniques sélectionnées spécialement pour vous.",
          "price": "25 000 Fcfa",
          "duration": "3-4 heures",
          "rating": 4.8,
          "reviews": 42,
          "location": "Ouidah, Benin",
          "includes": [
            "Guide personnel",
            "Transport inclus",
            "Collation traditionnelle",
            "Photos souvenirs",
          ],
          "activities": [
            "Visite personnalisée du musée d'histoire",
            "Rencontre avec des artisans locaux",
            "Dégustation de spécialités béninoises",
            "Atelier d'art traditionnel",
          ],
        };
      case "Culture & Histoire":
        return {
          "description":
              "Plongez dans la riche histoire de Ouidah, ancien port négrier devenu symbole de réconciliation. Découvrez les traditions et la culture béninoise authentique.",
          "price": "20 000 Fcfa",
          "duration": "2-3 heures",
          "rating": 4.9,
          "reviews": 68,
          "location": "Centre historique, Ouidah",
          "includes": [
            "Guide historien",
            "Entrées aux musées",
            "Documentation",
            "Certificat de visite",
          ],
          "activities": [
            "Musée d'Histoire de Ouidah",
            "Route des Esclaves",
            "Fort Português",
            "Temple des Pythons",
          ],
        };
      case "Hébergements":
        return {
          "description":
              "Découvrez les meilleurs hébergements de Ouidah, des maisons d'hôtes authentiques aux hôtels modernes, tous sélectionnés pour leur qualité et leur authenticité.",
          "price": "50 000 Fcfa/nuit",
          "duration": "Séjour flexible",
          "rating": 4.7,
          "reviews": 156,
          "location": "Ouidah et environs",
          "includes": [
            "Petit-déjeuner inclus",
            "Wi-Fi gratuit",
            "Service de conciergerie",
            "Transfert aéroport",
          ],
          "activities": [
            "Maisons d'hôtes traditionnelles",
            "Hôtels de charme",
            "Lodges écologiques",
            "Villas privées",
          ],
        };
      case "Découvertes":
        return {
          "description":
              "Explorez les trésors cachés de Ouidah et ses environs. Des sites naturels aux marchés locaux, vivez des moments uniques et authentiques.",
          "price": "30 000 Fcfa",
          "duration": "Une journée complète",
          "rating": 4.6,
          "reviews": 89,
          "location": "Ouidah et région",
          "includes": [
            "Transport 4x4",
            "Guide expérimenté",
            "Déjeuner local",
            "Matériel d'observation",
          ],
          "activities": [
            "Lac Ahémé",
            "Forêt sacrée de Kpassè",
            "Marché de Ganvié",
            "Villages traditionnels",
          ],
        };
      default:
        return {
          "description": "Une expérience unique à Ouidah",
          "price": "25 000 Fcfa",
          "duration": "2-3 heures",
          "rating": 4.5,
          "reviews": 25,
          "location": "Ouidah, Benin",
          "includes": [],
          "activities": [],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = _getExperienceImages(widget.experience['title'] ?? '');
    final details = _getExperienceDetails(widget.experience['title'] ?? '');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GALERIE D'IMAGES
            _buildImageGallery(images),

            // CONTENU PRINCIPAL
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITRE ET ACTIONS
                  _buildTitleSection(details),

                  const SizedBox(height: 16),

                  // INFORMATIONS ESSENTIELLES
                  _buildInfoSection(details),

                  const SizedBox(height: 20),

                  // DESCRIPTION
                  _buildDescriptionSection(details),

                  const SizedBox(height: 20),

                  // CE QUI EST INCLUS
                  _buildIncludesSection(details),

                  const SizedBox(height: 20),

                  // ACTIVITÉS
                  _buildActivitiesSection(details),

                  const SizedBox(height: 20),

                  // AVIS
                  _buildReviewsSection(details),

                  const SizedBox(height: 100), // Espace pour le bouton flottant
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildBookingButton(details),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildImageGallery(List<String> images) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigation vers visualiseur d'images
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => _FullScreenImageViewer(
                            images: images,
                            initialIndex: index,
                          ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'experience_image_$index',
                  child: Image.asset(
                    images[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        // BOUTONS DE NAVIGATION
        Positioned(
          top: 40,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF6B2E2E)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        Positioned(
          top: 40,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: Icon(
                _favoritesService.isFavorite(widget.experience)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () async {
                await _favoritesService.toggleFavorite(widget.experience);
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _favoritesService.isFavorite(widget.experience)
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

        // INDICATEUR D'IMAGES
        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  images.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentImageIndex == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                      ),
                    );
                  }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleSection(Map<String, dynamic> details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.experience['title'] ?? 'Expérience',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                details['location'] ?? 'Ouidah, Benin',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Color(0xFF6B2E2E)),
          onPressed: () {
            // Action de partage
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Partage (fonctionnalité à venir)'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoSection(Map<String, dynamic> details) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            Icons.schedule,
            'Durée',
            details['duration'] ?? '2-3h',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            Icons.star,
            'Note',
            '${details['rating']} (${details['reviews']})',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            Icons.payments,
            'Prix',
            details['price'] ?? '25 000 Fcfa',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF6B2E2E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6B2E2E), size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B2E2E),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(Map<String, dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          details['description'] ?? 'Description non disponible',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildIncludesSection(Map<String, dynamic> details) {
    final includes = details['includes'] as List<dynamic>? ?? [];

    if (includes.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ce qui est inclus',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...includes.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF6B2E2E),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(item.toString(), style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesSection(Map<String, dynamic> details) {
    final activities = details['activities'] as List<dynamic>? ?? [];

    if (activities.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activités',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...activities.map(
          (activity) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.place, color: Color(0xFF6B2E2E), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    activity.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection(Map<String, dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Avis des voyageurs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Navigation vers tous les avis
              },
              child: const Text(
                'Voir tout',
                style: TextStyle(color: Color(0xFF6B2E2E)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFF6B2E2E), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${details['rating']} sur 5',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${details['reviews']} avis',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                '"Expérience incroyable ! Guide très compétent et activités passionnantes. Je recommande vivement cette découverte de Ouidah."',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingButton(Map<String, dynamic> details) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          // Navigation vers la page de réservation
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ReservationPage(
                    property: {
                      'title': widget.experience['title'],
                      'subtitle': widget.experience['subtitle'],
                      'image': widget.experience['image'],
                      'location': details['location'],
                      'price':
                          details['price']
                              ?.toString()
                              .replaceAll(' Fcfa', '')
                              .replaceAll(' ', '') ??
                          '25000',
                      'rating': details['rating'],
                      'reviews': details['reviews'],
                      'distance': '1,500 kilometers',
                      'dates':
                          '${DateTime.now().day}/${DateTime.now().month} – ${DateTime.now().add(const Duration(days: 3)).day}/${DateTime.now().add(const Duration(days: 3)).month}',
                      'type':
                          'experience', // Identifier que c'est une expérience
                    },
                  ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B2E2E),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Réserver • ${details['price']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Widget pour l'affichage plein écran des images
class _FullScreenImageViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Center(
            child: Hero(
              tag: 'experience_image_$index',
              child: InteractiveViewer(
                child: Image.asset(images[index], fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }
}
