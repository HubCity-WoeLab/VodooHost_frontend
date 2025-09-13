import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

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
          "Aide",
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
            // Section Contact
            _buildContactSection(),

            const SizedBox(height: 24),

            // Section FAQ
            _buildFAQSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF884B4B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nous contacter",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF884B4B),
            ),
          ),
          const SizedBox(height: 16),

          _buildContactItem(
            Icons.phone,
            "Téléphone",
            "+229 XX XX XX XX",
            "Disponible 24h/7j",
          ),

          const SizedBox(height: 12),

          _buildContactItem(
            Icons.email,
            "Email",
            "support@vodoundays.com",
            "Réponse sous 24h",
          ),

          const SizedBox(height: 12),

          _buildContactItem(
            Icons.chat,
            "Chat en direct",
            "Chat disponible",
            "Lun-Ven 8h-18h",
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String value,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF884B4B),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF884B4B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Questions fréquentes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF884B4B),
          ),
        ),
        const SizedBox(height: 16),

        _buildFAQItem(
          "Comment puis-je réserver un hébergement ?",
          "Pour réserver un hébergement, parcourez notre catalogue, sélectionnez votre propriété préférée, choisissez vos dates et suivez le processus de réservation en ligne.",
        ),

        _buildFAQItem(
          "Puis-je annuler ma réservation ?",
          "Oui, vous pouvez annuler votre réservation depuis la section 'Mes Séjours'. Les conditions d'annulation varient selon la propriété et la date de votre séjour.",
        ),

        _buildFAQItem(
          "Comment modifier mes informations de profil ?",
          "Allez dans votre profil, appuyez sur 'Modifier le profil' et mettez à jour vos informations personnelles.",
        ),

        _buildFAQItem(
          "Quelles sont les méthodes de paiement acceptées ?",
          "Nous acceptons les cartes de crédit/débit et les paiements Mobile Money (MTN Money, Moov Money).",
        ),

        _buildFAQItem(
          "Comment contacter le propriétaire ?",
          "Une fois votre réservation confirmée, vous recevrez les coordonnées du propriétaire pour organiser votre arrivée.",
        ),

        _buildFAQItem(
          "Que faire en cas de problème durant mon séjour ?",
          "Contactez immédiatement notre support client disponible 24h/7j via téléphone ou chat en direct.",
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF884B4B),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey.shade700, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
