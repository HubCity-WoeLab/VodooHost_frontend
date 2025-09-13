import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  final Map<String, dynamic> reservationDetails;
  final Map<String, dynamic> property;

  const PaymentSuccessPage({
    Key? key,
    required this.reservationDetails,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF884B4B), // Marron de fond
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Payment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),

                // Cercle avec check
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 6),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 70),
                ),

                const SizedBox(height: 30),
                const Text(
                  "Félicitation!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Le paiement est réussi",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

                const SizedBox(height: 60),

                // Carte d'info réservation
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E3B3B), // Marron plus foncé
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous avez réservé avec succès votre hébergement pour",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getEventName(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Ligne date et heure
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _getDateRange(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "10:00",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Informations supplémentaires sur la réservation
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            _buildReservationInfo(
                              "Lieu",
                              property['location'] ?? "Ouidah, Bénin",
                            ),
                            const SizedBox(height: 6),
                            _buildReservationInfo(
                              "Invités",
                              "${reservationDetails['adults'] ?? 1} adulte${(reservationDetails['adults'] ?? 1) > 1 ? 's' : ''}${(reservationDetails['children'] ?? 0) > 0 ? ', ${reservationDetails['children']} enfant${(reservationDetails['children'] ?? 0) > 1 ? 's' : ''}' : ''}",
                            ),
                            const SizedBox(height: 6),
                            _buildReservationInfo(
                              "Durée",
                              "${reservationDetails['numberOfNights'] ?? 2} nuit${(reservationDetails['numberOfNights'] ?? 2) > 1 ? 's' : ''}",
                            ),
                            const SizedBox(height: 6),
                            _buildReservationInfo(
                              "Montant payé",
                              "${reservationDetails['totalPrice']?.toStringAsFixed(0) ?? '60000'} FCFA",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Boutons d'action
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF884B4B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Retourner à l'écran principal
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                        child: const Text(
                          "Retour à l'accueil",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          _showReservationDetails(context);
                        },
                        child: const Text(
                          "Voir les détails",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getEventName() {
    // Extraire un nom d'événement basé sur la localisation ou utiliser un nom par défaut
    String location = property['location'] ?? "Ouidah, Bénin";
    if (location.toLowerCase().contains('ouidah')) {
      return "VODOUN DAYS";
    } else if (location.toLowerCase().contains('abomey')) {
      return "FESTIVAL ROYAL D'ABOMEY";
    } else if (location.toLowerCase().contains('porto-novo')) {
      return "PATRIMOINE PORTO-NOVO";
    } else if (location.toLowerCase().contains('parakou')) {
      return "CULTURE DU NORD";
    } else {
      return "SÉJOUR AU BÉNIN";
    }
  }

  String _getDateRange() {
    String checkIn = reservationDetails['checkIn'] ?? 'Du Mer 23 Avril 2025';
    String checkOut = reservationDetails['checkOut'] ?? 'Au Jeu 24 Avril';

    return "$checkIn\n$checkOut";
  }

  Widget _buildReservationInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showReservationDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Détails de la réservation",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF884B4B),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow(
                  "Nom",
                  reservationDetails['name'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Email",
                  reservationDetails['email'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Téléphone",
                  reservationDetails['phone'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Propriété",
                  property['location'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Arrivée",
                  reservationDetails['checkIn'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Départ",
                  reservationDetails['checkOut'] ?? 'Non spécifié',
                ),
                _buildDetailRow(
                  "Invités",
                  "${reservationDetails['adults'] ?? 1} adulte${(reservationDetails['adults'] ?? 1) > 1 ? 's' : ''}${(reservationDetails['children'] ?? 0) > 0 ? ', ${reservationDetails['children']} enfant${(reservationDetails['children'] ?? 0) > 1 ? 's' : ''}' : ''}",
                ),
                _buildDetailRow(
                  "Durée",
                  "${reservationDetails['numberOfNights'] ?? 2} nuit${(reservationDetails['numberOfNights'] ?? 2) > 1 ? 's' : ''}",
                ),
                _buildDetailRow(
                  "Montant total",
                  "${reservationDetails['totalPrice']?.toStringAsFixed(0) ?? '60000'} FCFA",
                ),
                if (reservationDetails['specialRequest'] != null &&
                    reservationDetails['specialRequest'].toString().isNotEmpty)
                  _buildDetailRow(
                    "Demandes spéciales",
                    reservationDetails['specialRequest'],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Fermer",
                style: TextStyle(
                  color: Color(0xFF884B4B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF884B4B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
