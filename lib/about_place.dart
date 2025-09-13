import 'package:flutter/material.dart';

class AboutPlacePage extends StatelessWidget {
  const AboutPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Bouton de fermeture (X)
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 28,
                    color: Colors.black87,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 8),

              /// Titre principal
              const Text(
                "À propos de cet endroit",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 12),

              /// Introduction
              const Text(
                "Profitez d'une élégante chambre privée de 20 m² dans un appartement rénové de 160 m² "
                "au cœur du centre-ville d'Ouidah dans le quartier historique.\n\n"
                "Le charme de l'ancien rénové : hauteur sous plafond de 3,60 m, parquet d'époque, "
                "cheminée en marbre noir, salle de bain confortable.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              /// Sous-titre
              const Text(
                "L'espace",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 10),

              /// Détails
              const Text(
                "Poussez la porte de ce bâtiment colonial de 1890. "
                "Vous accéderez à un hall majestueux et monterez un large escalier en pierre au 2ème étage.\n\n"
                "La chambre peut accueillir 2 personnes. Si vous voyagez avec 1 adulte supplémentaire, "
                "la chambre Ouidah dans la même unité peut éventuellement l'accueillir selon la disponibilité.\n\n"
                "Vous serez proche de toutes les commodités du centre-ville : restaurants, cafés, "
                "marché traditionnel, épiceries et tous commerces.\n\n"
                "Le point central des transports en commun d'Ouidah (bus, taxi-moto) "
                "est à 2 minutes à pied du bâtiment.\n\n"
                "La gare routière est à 10 minutes à pied pour rejoindre Cotonou. "
                "Pour nos amis qui aiment la mobilité douce, des vélos de location "
                "sont disponibles près du bâtiment.\n\n"
                "Découvrez la Route des Esclaves, le Temple des Pythons, la Porte du Non-Retour "
                "et la riche histoire culturelle du Bénin à quelques pas de votre hébergement.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              /// Section culture locale
              const Text(
                "Culture locale",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Ouidah est le berceau du vaudou au Bénin. Participez aux cérémonies traditionnelles, "
                "visitez les temples sacrés et découvrez l'artisanat local. "
                "Notre hôte peut vous organiser des visites guidées authentiques "
                "pour une expérience culturelle immersive.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
