import 'package:flutter/material.dart';
import 'payment_success.dart';

class PaymentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> reservationDetails;
  final Map<String, dynamic> property;
  final String? cardNumber; // Les 4 derniers chiffres de la carte
  final String? paymentMethod;

  const PaymentDetailsPage({
    super.key,
    required this.reservationDetails,
    required this.property,
    this.cardNumber,
    this.paymentMethod,
  });

  static const Color primaryColor = Color(0xFF8B4B4B); // Marron rouge du design
  static const Color backgroundColor = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    double totalAmount = reservationDetails['totalPrice']?.toDouble() ?? 60000;
    String formattedAmount = totalAmount.toStringAsFixed(0);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Méthode de payement",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                "$formattedAmount FCFA",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hebergement",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    "Date / Heure",
                    "${reservationDetails['checkIn'] ?? 'Du Mar 25 Avr'} / 10:00\n${reservationDetails['checkOut'] ?? 'Au Mar 26 Avr'} / 10:00",
                  ),
                  _buildInfoRow(
                    "Durée",
                    "${reservationDetails['numberOfNights'] ?? 2} Jours",
                  ),
                  _buildInfoRow("Réservation pour", "Autre personne"),
                  const Divider(thickness: 1, height: 32),
                  _buildInfoRow("Montant", "$formattedAmount FCFA"),
                  _buildInfoRow(
                    "Parti de",
                    property['location'] ?? "Ouidah, Bénin",
                  ),
                  _buildInfoRow("Total", formattedAmount),
                  const Divider(thickness: 1, height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Méthode de payement",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "${_getPaymentMethodDisplay()}  Changer",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () => _processPayment(context),
                        child: const Text(
                          "Payez",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodDisplay() {
    switch (paymentMethod?.toLowerCase()) {
      case 'card':
      case 'carte':
        return cardNumber != null && cardNumber!.isNotEmpty
            ? "Card ••••${cardNumber!.length >= 4 ? cardNumber!.substring(cardNumber!.length - 4) : cardNumber}"
            : "Card";
      case 'mtn':
        return 'MTN Money';
      case 'moov':
        return 'Moov Money';
      default:
        return 'Card';
    }
  }

  void _processPayment(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              const SizedBox(height: 16),
              const Text(
                "Traitement du paiement...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );

    // Simuler le traitement du paiement
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Fermer le dialog de chargement

      // Naviguer vers la page de succès
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => PaymentSuccessPage(
                reservationDetails: reservationDetails,
                property: property,
              ),
        ),
      );
    });
  }
}
