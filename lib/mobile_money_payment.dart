import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment_success.dart';

class MobileMoneyPaymentPage extends StatefulWidget {
  final Map<String, dynamic> reservationDetails;
  final Map<String, dynamic> property;
  final String paymentMethod; // 'mtn' or 'moov'

  const MobileMoneyPaymentPage({
    super.key,
    required this.reservationDetails,
    required this.property,
    required this.paymentMethod,
  });

  @override
  State<MobileMoneyPaymentPage> createState() => _MobileMoneyPaymentPageState();
}

class _MobileMoneyPaymentPageState extends State<MobileMoneyPaymentPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  static const Color primaryColor = Colors.brown;

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        widget.reservationDetails['totalPrice']?.toDouble() ?? 60000;
    String formattedAmount = totalAmount.toStringAsFixed(0);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Paiement ${_getProviderName()}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header avec logo et montant
          Container(
            width: double.infinity,
            color: Colors.brown,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Logo du provider
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getProviderIcon(),
                    size: 40,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "$formattedAmount FCFA",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Montant à payer",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Champ numéro de téléphone
                    Text(
                      "Numéro ${_getProviderName()}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                        _PhoneNumberFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: "${_getProviderPrefix()} XX XX XX XX",
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.brown,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le numéro de téléphone est requis';
                        }
                        String cleanNumber = value.replaceAll(' ', '');
                        if (cleanNumber.length != 8) {
                          return 'Le numéro doit contenir 8 chiffres';
                        }
                        if (!cleanNumber.startsWith(
                          _getProviderPrefix().replaceAll(' ', ''),
                        )) {
                          return 'Numéro ${_getProviderName()} invalide';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Champ PIN
                    Text(
                      "Code PIN ${_getProviderName()}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: InputDecoration(
                        hintText: "Entrez votre code PIN",
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.brown,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le code PIN est requis';
                        }
                        if (value.length != 4) {
                          return 'Le code PIN doit contenir 4 chiffres';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Récapitulatif
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Récapitulatif",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildSummaryRow(
                            "Propriété",
                            widget.property['location'] ?? "Hébergement",
                          ),
                          _buildSummaryRow(
                            "Durée",
                            "${widget.reservationDetails['numberOfNights'] ?? 2} nuits",
                          ),
                          _buildSummaryRow(
                            "Invités",
                            "${widget.reservationDetails['adults'] ?? 1} adulte(s)",
                          ),
                          const Divider(height: 20),
                          _buildSummaryRow(
                            "Total à payer",
                            "$formattedAmount FCFA",
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Bouton de paiement
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
            child: ElevatedButton(
              onPressed: _isLoading ? null : _processMobileMoneyPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        "Payer $formattedAmount FCFA",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? primaryColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _getProviderName() {
    switch (widget.paymentMethod.toLowerCase()) {
      case 'mtn':
        return 'MTN Mobile Money';
      case 'moov':
        return 'Moov Money';
      default:
        return 'Mobile Money';
    }
  }

  IconData _getProviderIcon() {
    switch (widget.paymentMethod.toLowerCase()) {
      case 'mtn':
        return Icons.phone_android;
      case 'moov':
        return Icons.phone_iphone;
      default:
        return Icons.phone;
    }
  }

  String _getProviderPrefix() {
    switch (widget.paymentMethod.toLowerCase()) {
      case 'mtn':
        return '96 '; // MTN Bénin commence par 96
      case 'moov':
        return '97 '; // Moov Bénin commence par 97
      default:
        return '9X ';
    }
  }

  void _processMobileMoneyPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulation du processus de paiement
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigation vers la page de succès
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => PaymentSuccessPage(
                  reservationDetails: widget.reservationDetails,
                  property: widget.property,
                ),
          ),
        );
      }
    }
  }
}

// Formatter pour le numéro de téléphone
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', '');

    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4 || i == 6) {
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
