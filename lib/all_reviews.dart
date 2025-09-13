import 'package:flutter/material.dart';
import 'widget/constants.dart';

class AllReviewsPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const AllReviewsPage({super.key, required this.property});

  @override
  State<AllReviewsPage> createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  String selectedFilter = 'Tous';
  final List<String> filters = [
    'Tous',
    '5 étoiles',
    '4 étoiles',
    '3 étoiles',
    '2 étoiles',
    '1 étoile',
  ];

  // Liste simulée d'avis plus complète
  final List<Map<String, dynamic>> allReviews = [
    {
      'name': 'Emma Durand',
      'rating': 5,
      'date': 'Décembre 2024',
      'review':
          'Excellent emplacement ! Avec la climatisation et proximité de la gare. L\'hôte était très accueillant et la chambre parfaitement propre. Je recommande vivement pour un séjour à Ouidah.',
      'helpful': 8,
    },
    {
      'name': 'Jean Baptiste',
      'rating': 5,
      'date': 'Novembre 2024',
      'review':
          'Très propre et accueillant. Je recommande vivement! La location correspond exactement aux photos et la communication avec l\'hôte était parfaite.',
      'helpful': 12,
    },
    {
      'name': 'Marie Koffi',
      'rating': 4,
      'date': 'Octobre 2024',
      'review':
          'Bon séjour dans l\'ensemble. La chambre était confortable et bien équipée. Seul bémol : un peu de bruit le matin mais rien de dérangeant. L\'emplacement est vraiment idéal pour visiter le centre historique.',
      'helpful': 5,
    },
    {
      'name': 'Pierre Dossa',
      'rating': 5,
      'date': 'Septembre 2024',
      'review':
          'Séjour parfait ! L\'hôte nous a donné d\'excellents conseils pour visiter Ouidah. La Route des Esclaves est à quelques minutes à pied. Chambre spacieuse et très propre.',
      'helpful': 15,
    },
    {
      'name': 'Sarah Johnson',
      'rating': 4,
      'date': 'Août 2024',
      'review':
          'Great location in Ouidah! The room was clean and comfortable. The host was very responsive and helpful. Would definitely stay again when visiting Benin.',
      'helpful': 7,
    },
    {
      'name': 'Amadou Traoré',
      'rating': 5,
      'date': 'Juillet 2024',
      'review':
          'Logement exceptionnel ! Tout était parfait : propreté, emplacement, accueil. Les conseils de l\'hôte pour découvrir la culture béninoise étaient précieux. Merci pour cette belle expérience !',
      'helpful': 20,
    },
    {
      'name': 'Fatou Diallo',
      'rating': 3,
      'date': 'Juin 2024',
      'review':
          'Séjour correct. La chambre était propre mais un peu petite pour deux personnes. L\'emplacement est bon et l\'hôte sympathique. Rapport qualité-prix acceptable.',
      'helpful': 3,
    },
    {
      'name': 'Michel Dupont',
      'rating': 5,
      'date': 'Mai 2024',
      'review':
          'Une expérience formidable ! L\'authenticité du lieu, la gentillesse de l\'hôte et la proximité avec les sites historiques font de ce logement un choix parfait pour découvrir Ouidah.',
      'helpful': 18,
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    if (selectedFilter == 'Tous') return allReviews;
    int targetRating = int.parse(selectedFilter.split(' ')[0]);
    return allReviews
        .where((review) => review['rating'] == targetRating)
        .toList();
  }

  double get averageRating {
    if (allReviews.isEmpty) return 0;
    double sum = allReviews.fold(0, (sum, review) => sum + review['rating']);
    return sum / allReviews.length;
  }

  Map<int, int> get ratingCounts {
    Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in allReviews) {
      counts[review['rating']] = counts[review['rating']]! + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryRed),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Avis des voyageurs',
          style: TextStyle(
            color: AppColors.secondaryRed,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // EN-TÊTE AVEC STATISTIQUES
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // Note globale
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.primaryGold, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryRed,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${allReviews.length} avis)',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Répartition des étoiles
                ...List.generate(5, (index) {
                  int stars = 5 - index;
                  int count = ratingCounts[stars]!;
                  double percentage =
                      allReviews.isNotEmpty ? count / allReviews.length : 0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Text('$stars'),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.star,
                          color: AppColors.primaryGold,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryGold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('$count'),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // FILTRES
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    selectedColor: AppColors.primaryPink.withOpacity(0.2),
                    checkmarkColor: AppColors.secondaryRed,
                    labelStyle: TextStyle(
                      color:
                          isSelected
                              ? AppColors.secondaryRed
                              : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // LISTE DES AVIS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return _buildDetailedReviewTile(review);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedReviewTile(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec avatar et infos
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.secondaryBeige.withOpacity(0.3),
                child: Text(
                  review['name'].split(' ').map((n) => n[0]).join(''),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryRed,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: AppColors.primaryGold,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Texte de l'avis
          Text(
            review['review'],
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Merci pour votre retour !"),
                      backgroundColor: AppColors.secondaryRed,
                    ),
                  );
                },
                icon: Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: AppColors.secondaryRed,
                ),
                label: Text(
                  'Utile (${review['helpful']})',
                  style: TextStyle(color: AppColors.secondaryRed),
                ),
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Avis signalé !"),
                      backgroundColor: AppColors.secondaryRed,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.flag_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                label: const Text(
                  'Signaler',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
