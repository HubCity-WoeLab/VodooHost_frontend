import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

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
          "Politique de confidentialité",
          style: TextStyle(
            color: Color(0xFF884B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "1. Collecte des informations",
              "Nous collectons les informations que vous nous fournissez directement, comme lorsque vous créez un compte, effectuez une réservation, ou nous contactez.",
            ),

            _buildSection(
              "2. Utilisation des informations",
              "Nous utilisons vos informations pour : traiter vos réservations, améliorer nos services, vous envoyer des communications importantes, et personnaliser votre expérience.",
            ),

            _buildSection(
              "3. Partage des informations",
              "Nous ne vendons pas vos informations personnelles. Nous pouvons partager vos informations avec les propriétaires d'hébergements pour faciliter votre séjour.",
            ),

            _buildSection(
              "4. Sécurité",
              "Nous mettons en place des mesures de sécurité appropriées pour protéger vos informations personnelles contre l'accès non autorisé, l'altération ou la destruction.",
            ),

            _buildSection(
              "5. Cookies",
              "Nous utilisons des cookies pour améliorer votre expérience sur notre plateforme. Vous pouvez gérer vos préférences de cookies dans les paramètres de votre navigateur.",
            ),

            _buildSection(
              "6. Vos droits",
              "Vous avez le droit d'accéder, de corriger, de supprimer vos données personnelles, et de vous opposer à leur traitement dans certaines circonstances.",
            ),

            _buildSection(
              "7. Modifications",
              "Nous pouvons modifier cette politique de confidentialité. Les modifications seront publiées sur cette page avec une date de mise à jour.",
            ),

            _buildSection(
              "8. Contact",
              "Pour toute question concernant cette politique, contactez-nous à privacy@vodoundays.com ou +229 XX XX XX XX.",
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF884B4B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dernière mise à jour",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF884B4B),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "13 septembre 2025",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF884B4B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
