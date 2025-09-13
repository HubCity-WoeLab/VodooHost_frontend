import 'package:flutter/material.dart';
import 'add_card.dart';
import 'payment_details.dart';
import 'mobile_money_payment.dart';

class PaymentMethodPage extends StatefulWidget {
  final Map<String, dynamic>? reservationDetails;
  final Map<String, dynamic>? property;

  const PaymentMethodPage({super.key, this.reservationDetails, this.property});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedPayment = "card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Méthode de paiement",
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// SECTION 1 - Carte de crédit & débit
                  const Text(
                    "Carte De Crédit & Débit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _paymentOption(
                    id: "card",
                    icon: Icons.credit_card,
                    label: "Ajouter Une Carte",
                  ),

                  const SizedBox(height: 25),

                  /// SECTION 2 - Mobile Money
                  const Text(
                    "Mobile Money",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _paymentOption(
                    id: "mtn",
                    icon: Icons.phone_android,
                    label: "MTN Mobile Money",
                  ),
                  const SizedBox(height: 12),
                  _paymentOption(
                    id: "moov",
                    icon: Icons.phone_android,
                    label: "Moov Money",
                  ),
                  const SizedBox(height: 12),
                  _paymentOption(
                    id: "orange",
                    icon: Icons.phone_android,
                    label: "Orange Money",
                  ),

                  const SizedBox(height: 25),

                  /// SECTION 3 - Autres options
                  const Text(
                    "Plus D'options De Paiement",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _paymentOption(
                    id: "google",
                    icon: Icons.account_balance_wallet,
                    label: "Google Pay",
                  ),
                  const SizedBox(height: 12),
                  _paymentOption(
                    id: "apple",
                    icon: Icons.apple,
                    label: "Apple Pay",
                  ),
                  const SizedBox(height: 12),
                  _paymentOption(
                    id: "paypal",
                    icon: Icons.payment,
                    label: "PayPal",
                  ),
                ],
              ),
            ),
          ),

          /// Bouton de validation en bas
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _proceedWithPayment();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    selectedPayment == "card"
                        ? "Ajouter une carte"
                        : "Continuer avec cette méthode",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget réutilisable pour une option de paiement
  Widget _paymentOption({
    required String id,
    required IconData icon,
    required String label,
  }) {
    final bool selected = selectedPayment == id;

    return GestureDetector(
      onTap: () {
        // Navigation spéciale pour l'ajout de carte
        if (id == "card") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AddCardPage(
                    reservationDetails: widget.reservationDetails,
                    property: widget.property,
                  ),
            ),
          );
        } else if ((id == "mtn" || id == "moov") &&
            widget.reservationDetails != null &&
            widget.property != null) {
          // Navigation directe vers Mobile Money
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MobileMoneyPaymentPage(
                    reservationDetails: widget.reservationDetails!,
                    property: widget.property!,
                    paymentMethod: id,
                  ),
            ),
          );
        } else {
          setState(() {
            selectedPayment = id;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.brown : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
          color: selected ? Colors.brown.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.brown, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown,
                ),
              ),
            ),
            Icon(
              id == "card"
                  ? Icons.arrow_forward_ios
                  : (selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off),
              color: Colors.brown,
              size: id == "card" ? 18 : null,
            ),
          ],
        ),
      ),
    );
  }

  void _proceedWithPayment() {
    // Navigation spéciale pour l'ajout de carte
    if (selectedPayment == "card") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => AddCardPage(
                reservationDetails: widget.reservationDetails,
                property: widget.property,
              ),
        ),
      );
      return;
    }

    // Navigation vers Mobile Money pour MTN et Moov
    if ((selectedPayment == "mtn" || selectedPayment == "moov") &&
        widget.reservationDetails != null &&
        widget.property != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MobileMoneyPaymentPage(
                reservationDetails: widget.reservationDetails!,
                property: widget.property!,
                paymentMethod: selectedPayment,
              ),
        ),
      );
      return;
    }

    // Si nous avons les détails de réservation, naviguer vers la page de détails de paiement
    if (widget.reservationDetails != null && widget.property != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => PaymentDetailsPage(
                reservationDetails: widget.reservationDetails!,
                property: widget.property!,
                paymentMethod: selectedPayment,
              ),
        ),
      );
      return;
    }

    String paymentMethodName = _getPaymentMethodName(selectedPayment);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.brown,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Méthode sélectionnée',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              'Vous avez sélectionné $paymentMethodName comme méthode de paiement. La fonctionnalité de paiement sera bientôt disponible.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Close payment page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  String _getPaymentMethodName(String id) {
    switch (id) {
      case "card":
        return "Carte de crédit/débit";
      case "mtn":
        return "MTN Mobile Money";
      case "moov":
        return "Moov Money";
      case "orange":
        return "Orange Money";
      case "google":
        return "Google Pay";
      case "apple":
        return "Apple Pay";
      case "paypal":
        return "PayPal";
      default:
        return "Méthode de paiement";
    }
  }
}
