import 'package:flutter/material.dart';
import 'widget/constants.dart';

class TermsConditionsPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const TermsConditionsPage({super.key, required this.property});

  @override
  State<TermsConditionsPage> createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  String selectedTab = 'Règles';

  final List<String> tabs = ['Règles', 'Sécurité', 'Annulation', 'Paiement'];

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
          'Conditions et règles',
          style: TextStyle(
            color: AppColors.secondaryRed,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // ONGLETS
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children:
                  tabs
                      .map(
                        (tab) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = tab;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        selectedTab == tab
                                            ? AppColors.secondaryRed
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    color:
                                        selectedTab == tab
                                            ? AppColors.secondaryRed
                                            : Colors.grey[600],
                                    fontWeight:
                                        selectedTab == tab
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          // CONTENU
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 'Règles':
        return _buildRulesContent();
      case 'Sécurité':
        return _buildSecurityContent();
      case 'Annulation':
        return _buildCancellationContent();
      case 'Paiement':
        return _buildPaymentContent();
      default:
        return Container();
    }
  }

  Widget _buildRulesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Règles de la maison'),
        _buildRuleItem(Icons.access_time, 'Arrivée', '15h00 - 22h00'),
        _buildRuleItem(Icons.exit_to_app, 'Départ', 'Avant 11h00'),
        _buildRuleItem(Icons.group, 'Nombre maximum d\'invités', '6 personnes'),
        const SizedBox(height: 20),

        _buildSectionTitle('Autorisé'),
        _buildAllowedItem(Icons.pets, 'Animaux domestiques'),
        _buildAllowedItem(
          Icons.smoking_rooms,
          'Fumer à l\'extérieur uniquement',
        ),
        _buildAllowedItem(
          Icons.celebration,
          'Événements et fêtes avec accord préalable',
        ),
        _buildAllowedItem(Icons.child_friendly, 'Enfants bienvenus'),
        const SizedBox(height: 20),

        _buildSectionTitle('Interdit'),
        _buildForbiddenItem(Icons.volume_up, 'Nuisances sonores après 22h00'),
        _buildForbiddenItem(Icons.smoke_free, 'Fumer à l\'intérieur'),
        _buildForbiddenItem(
          Icons.no_food,
          'Cuisiner avec des produits à forte odeur',
        ),
        _buildForbiddenItem(Icons.block, 'Inviter des personnes non déclarées'),
        const SizedBox(height: 20),

        _buildSectionTitle('Règles spécifiques au Bénin'),
        _buildInfoBox(
          'Respect des traditions locales',
          'Nous encourageons nos hôtes à respecter les coutumes et traditions béninoises. '
              'N\'hésitez pas à demander des conseils à votre hôte concernant les pratiques culturelles locales.',
        ),
        const SizedBox(height: 12),
        _buildInfoBox(
          'Sécurité et santé',
          'Veuillez respecter les consignes de sécurité locales. '
              'En cas d\'urgence médicale, contactez immédiatement le +229 95 96 97 98.',
        ),
      ],
    );
  }

  Widget _buildSecurityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Équipements de sécurité'),
        _buildSecurityItem(
          Icons.security,
          'Détecteur de fumée',
          'Installé et vérifié',
        ),
        _buildSecurityItem(
          Icons.medical_services,
          'Trousse de premiers secours',
          'Disponible',
        ),
        _buildSecurityItem(
          Icons.fire_extinguisher,
          'Extincteur',
          'Présent et accessible',
        ),
        _buildSecurityItem(
          Icons.lock,
          'Serrures sécurisées',
          'Toutes les portes',
        ),
        const SizedBox(height: 20),

        _buildSectionTitle('Procédures d\'urgence'),
        _buildEmergencyCard(
          'Urgences médicales',
          '+229 95 96 97 98',
          'Hôpital le plus proche : CNHU-HKM, Cotonou',
          Icons.local_hospital,
        ),
        const SizedBox(height: 12),
        _buildEmergencyCard(
          'Police',
          '+229 117',
          'Commissariat central de Cotonou',
          Icons.local_police,
        ),
        const SizedBox(height: 12),
        _buildEmergencyCard(
          'Pompiers',
          '+229 118',
          'Caserne des pompiers de Cotonou',
          Icons.fire_truck,
        ),
        const SizedBox(height: 20),

        _buildSectionTitle('Conseils de sécurité'),
        _buildSafetyTip(
          'Toujours verrouiller les portes et fenêtres avant de sortir',
        ),
        _buildSafetyTip(
          'Ne pas laisser d\'objets de valeur visibles depuis l\'extérieur',
        ),
        _buildSafetyTip(
          'Éviter de sortir seul(e) tard le soir dans des zones peu éclairées',
        ),
        _buildSafetyTip(
          'Garder une copie de vos documents d\'identité dans un endroit sûr',
        ),
      ],
    );
  }

  Widget _buildCancellationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Politique d\'annulation flexible'),

        _buildCancellationRule(
          'Annulation gratuite',
          'Jusqu\'à 24 heures avant l\'arrivée',
          'Remboursement intégral moins les frais de service',
          AppColors.primaryGold,
          Icons.check_circle,
        ),
        const SizedBox(height: 12),

        _buildCancellationRule(
          'Annulation partielle',
          'Entre 24h et 12h avant l\'arrivée',
          '50% de remboursement',
          Colors.orange,
          Icons.warning,
        ),
        const SizedBox(height: 12),

        _buildCancellationRule(
          'Pas de remboursement',
          'Moins de 12h avant l\'arrivée ou non-présentation',
          'Aucun remboursement',
          AppColors.secondaryRed,
          Icons.cancel,
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Circonstances exceptionnelles'),

        _buildInfoBox(
          'Cas de force majeure',
          'En cas d\'événements exceptionnels (catastrophes naturelles, pandémie, troubles politiques), '
              'des conditions d\'annulation spéciales peuvent s\'appliquer. '
              'Contactez notre service client pour plus d\'informations.',
        ),
        const SizedBox(height: 12),

        _buildInfoBox(
          'Annulation par l\'hôte',
          'Si l\'hôte annule votre réservation, vous serez intégralement remboursé '
              'et nous vous aiderons à trouver un logement alternatif similaire.',
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Comment annuler'),

        _buildStepItem(1, 'Connectez-vous à votre compte'),
        _buildStepItem(2, 'Allez dans "Mes réservations"'),
        _buildStepItem(3, 'Sélectionnez la réservation à annuler'),
        _buildStepItem(4, 'Cliquez sur "Annuler la réservation"'),
        _buildStepItem(5, 'Confirmez votre annulation'),

        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: AppColors.secondaryRed),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Les remboursements sont traités sous 5-10 jours ouvrables '
                  'sur le mode de paiement original.',
                  style: TextStyle(color: AppColors.secondaryRed, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Modes de paiement acceptés'),

        _buildPaymentMethod(
          Icons.credit_card,
          'Cartes bancaires',
          'Visa, Mastercard, American Express',
        ),
        _buildPaymentMethod(
          Icons.account_balance,
          'Virement bancaire',
          'IBAN requis pour les virements',
        ),
        _buildPaymentMethod(
          Icons.phone_android,
          'Mobile Money',
          'MTN Money, Moov Money',
        ),
        _buildPaymentMethod(
          Icons.payments,
          'Paiement à l\'arrivée',
          'Espèces ou carte (selon accord)',
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Calendrier des paiements'),

        _buildPaymentSchedule(
          'À la réservation',
          '30% du montant total + frais de service',
          'Confirmation immédiate de la réservation',
        ),
        const SizedBox(height: 12),

        _buildPaymentSchedule(
          '7 jours avant l\'arrivée',
          '70% restants du montant total',
          'Paiement automatique ou manuel',
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Frais et taxes'),

        _buildFeeItem(
          'Frais de service VodooHost',
          '5% du montant de la réservation',
        ),
        _buildFeeItem(
          'Taxe de séjour (si applicable)',
          '500 FCFA par nuit et par personne',
        ),
        _buildFeeItem(
          'Frais de ménage',
          'Inclus dans le prix ou facturé séparément',
        ),
        _buildFeeItem(
          'Caution',
          'Peut être demandée par l\'hôte (remboursable)',
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Sécurité des paiements'),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryLight,
                AppColors.primaryPink.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.security, color: AppColors.secondaryRed, size: 32),
              const SizedBox(height: 12),
              Text(
                'Paiements sécurisés',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryRed,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Toutes vos transactions sont cryptées et sécurisées. '
                'Vos données bancaires ne sont jamais stockées sur nos serveurs.',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        _buildSectionTitle('Remboursements et litiges'),

        _buildInfoBox(
          'Garantie de remboursement',
          'Si le logement ne correspond pas à la description ou en cas de problème majeur, '
              'contactez notre service client dans les 24h suivant votre arrivée.',
        ),
        const SizedBox(height: 12),

        _buildInfoBox(
          'Résolution de litiges',
          'Notre équipe de médiation est disponible 24h/7j pour résoudre tout conflit '
              'entre hôtes et voyageurs de manière équitable.',
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryRed,
        ),
      ),
    );
  }

  Widget _buildRuleItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.secondaryRed, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllowedItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primaryGold, size: 18),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.grey[600], size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildForbiddenItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.cancel, color: AppColors.secondaryRed, size: 18),
          const SizedBox(width: 8),
          Icon(icon, color: Colors.grey[600], size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryPink.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryRed,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(IconData icon, String title, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.secondaryRed, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.verified, color: AppColors.primaryGold, size: 16),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard(
    String title,
    String number,
    String location,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade600, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                Text(
                  number,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade600,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: AppColors.primaryGold, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildCancellationRule(
    String title,
    String timeframe,
    String condition,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  timeframe,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  condition,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(int step, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.secondaryRed,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(description, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBeige.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.secondaryRed, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSchedule(
    String title,
    String amount,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryRed,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.monetization_on_outlined,
            color: AppColors.primaryGold,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
