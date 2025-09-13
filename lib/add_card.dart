import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment_details.dart';

class AddCardPage extends StatefulWidget {
  final Map<String, dynamic>? reservationDetails;
  final Map<String, dynamic>? property;

  const AddCardPage({super.key, this.reservationDetails, this.property});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController nameController = TextEditingController(
    text: "JOHN DOE",
  );
  final TextEditingController numberController = TextEditingController(
    text: "0000 0000 0000 0000",
  );
  final TextEditingController expiryController = TextEditingController(
    text: "04/28",
  );
  final TextEditingController cvvController = TextEditingController(
    text: "000",
  );

  @override
  void initState() {
    super.initState();
    // Écouter les changements pour mettre à jour l'aperçu de la carte
    nameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    expiryController.addListener(() => setState(() {}));
    cvvController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

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
          "Ajouter une carte",
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// --- Carte Bancaire en aperçu ---
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade600, Colors.brown.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Icon(
                        _getCardIcon(numberController.text),
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _formatCardNumber(numberController.text),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "TITULAIRE DE LA CARTE",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              nameController.text.isEmpty
                                  ? "VOTRE NOM"
                                  : nameController.text.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "EXPIRE",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              expiryController.text.isEmpty
                                  ? "MM/AA"
                                  : expiryController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "CVV: ${cvvController.text}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// --- Champs de formulaire ---
            _buildTextField(
              "Nom du titulaire",
              nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              "Numéro de carte",
              numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              hintText: "0000 0000 0000 0000",
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    "Date d'expiration",
                    expiryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ExpiryDateFormatter(),
                    ],
                    hintText: "MM/AA",
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTextField(
                    "CVV",
                    cvvController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    hintText: "000",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Informations sécurisées
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.brown.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.brown, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Vos informations de paiement sont sécurisées et cryptées",
                      style: TextStyle(color: Colors.brown, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// --- Bouton Sauvegarde ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                onPressed: _isFormValid() ? _saveCard : null,
                child: const Text(
                  "Sauvegarder la carte",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget réutilisable pour les champs
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.brown),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.brown.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.brown, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.w500),
    );
  }

  /// Formatage du numéro de carte pour l'affichage
  String _formatCardNumber(String number) {
    String digits = number.replaceAll(' ', '');
    if (digits.isEmpty) return "0000 0000 0000 0000";

    // Compléter avec des 0 si nécessaire
    while (digits.length < 16) {
      digits += "0";
    }

    // Grouper par 4 chiffres
    return digits
        .replaceAllMapped(RegExp(r'(\d{4})'), (match) => '${match.group(0)} ')
        .trim();
  }

  /// Détection du type de carte
  IconData _getCardIcon(String number) {
    String digits = number.replaceAll(' ', '');
    if (digits.startsWith('4')) return Icons.credit_card; // Visa
    if (digits.startsWith('5')) return Icons.credit_card; // MasterCard
    return Icons.credit_card; // Défaut
  }

  /// Validation du formulaire
  bool _isFormValid() {
    return nameController.text.trim().isNotEmpty &&
        numberController.text.replaceAll(' ', '').length >= 16 &&
        expiryController.text.length >= 5 &&
        cvvController.text.length >= 3;
  }

  /// Sauvegarde de la carte
  void _saveCard() {
    // Si nous avons les détails de réservation, naviguer vers la page de détails de paiement
    if (widget.reservationDetails != null && widget.property != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => PaymentDetailsPage(
                reservationDetails: widget.reservationDetails!,
                property: widget.property!,
                cardNumber: numberController.text.replaceAll(' ', ''),
                paymentMethod: 'carte',
              ),
        ),
      );
    } else {
      // Sinon, afficher le dialog de succès comme avant
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
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Carte sauvegardée',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: const Text(
                'Votre carte a été ajoutée avec succès et peut maintenant être utilisée pour vos paiements.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.4),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Close add card page
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      );
    }
  }
}

/// Formatter pour le numéro de carte
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', '');

    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatter pour la date d'expiration
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll('/', '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        formatted += '/';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
