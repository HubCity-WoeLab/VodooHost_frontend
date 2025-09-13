import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment_method.dart';

class ReservationPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const ReservationPage({super.key, required this.property});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs de texte
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialRequestController =
      TextEditingController();

  // Dates
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  // Nombre de personnes
  int _adults = 1;
  int _children = 0;

  // Nombre de nuits
  int get _numberOfNights {
    if (_checkInDate != null && _checkOutDate != null) {
      return _checkOutDate!.difference(_checkInDate!).inDays;
    }
    return 1;
  }

  // Prix total
  double get _totalPrice {
    double pricePerNight =
        double.tryParse(
          widget.property['price']?.toString().replaceAll(',', '') ?? '30000',
        ) ??
        30000;
    return pricePerNight * _numberOfNights;
  }

  @override
  void initState() {
    super.initState();
    // Ajouter des listeners pour mettre à jour l'état du bouton
    _nameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
    _phoneController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      // Force la reconstruction du widget pour mettre à jour l'état du bouton
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateButtonState);
    _emailController.removeListener(_updateButtonState);
    _phoneController.removeListener(_updateButtonState);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialRequestController.dispose();
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
          "Réservation",
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Récapitulatif de la propriété
                    _buildPropertySummary(),

                    const SizedBox(height: 24),

                    // Section dates
                    _buildDateSection(),

                    const SizedBox(height: 24),

                    // Section nombre de personnes
                    _buildGuestSection(),

                    const SizedBox(height: 24),

                    // Section informations personnelles
                    _buildPersonalInfoSection(),

                    const SizedBox(height: 24),

                    // Section demandes spéciales
                    _buildSpecialRequestSection(),

                    const SizedBox(height: 24),

                    // Récapitulatif du prix
                    _buildPriceSummary(),

                    const SizedBox(height: 80), // Espace pour le bouton fixé
                  ],
                ),
              ),
            ),
          ),

          // Bouton payer fixé en bas
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
                  onPressed: _isFormValid() ? _proceedToPayment : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    "Payer ${_totalPrice.toStringAsFixed(0)} CFA",
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

  Widget _buildPropertySummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.property['image'] ?? 'assets/images/logement.png',
              width: 80,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.property['location'] ?? 'Propriété',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.brown, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.property['rating'] ?? 4.9} · ${widget.property['reviews'] ?? 32} avis",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dates de séjour",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                "Arrivée",
                _checkInDate,
                (date) => setState(() => _checkInDate = date),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateField(
                "Départ",
                _checkOutDate,
                (date) => setState(() => _checkOutDate = date),
              ),
            ),
          ],
        ),
        if (_numberOfNights > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "$_numberOfNights nuit${_numberOfNights > 1 ? 's' : ''}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? date,
    Function(DateTime) onDateSelected,
  ) {
    return GestureDetector(
      onTap: () => _selectDate(context, date, onDateSelected),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.brown.withOpacity(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date != null
                  ? "${date.day}/${date.month}/${date.year}"
                  : "Sélectionner",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.brown,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nombre de personnes",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 12),
        _buildGuestCounter(
          "Adultes",
          _adults,
          (value) => setState(() => _adults = value),
        ),
        const SizedBox(height: 12),
        _buildGuestCounter(
          "Enfants",
          _children,
          (value) => setState(() => _children = value),
        ),
      ],
    );
  }

  Widget _buildGuestCounter(String label, int count, Function(int) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.brown.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.brown,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed:
                    count > (label == "Adultes" ? 1 : 0)
                        ? () => onChanged(count - 1)
                        : null,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color:
                      count > (label == "Adultes" ? 1 : 0)
                          ? Colors.brown
                          : Colors.grey,
                ),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              IconButton(
                onPressed: count < 10 ? () => onChanged(count + 1) : null,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: count < 10 ? Colors.brown : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informations personnelles",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _nameController,
          label: "Nom complet *",
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le nom est requis';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: "Email *",
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'L\'email est requis';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Email invalide';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _phoneController,
          label: "Téléphone *",
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le téléphone est requis';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSpecialRequestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Demandes spéciales",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Optionnel - Faites-nous savoir si vous avez des besoins particuliers",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _specialRequestController,
          label: "Demandes spéciales",
          maxLines: 3,
          hintText: "Ex: Arrivée tardive, allergies alimentaires, etc.",
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    double pricePerNight =
        double.tryParse(
          widget.property['price']?.toString().replaceAll(',', '') ?? '30000',
        ) ??
        30000;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Récapitulatif du prix",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${pricePerNight.toStringAsFixed(0)} CFA x $_numberOfNights nuit${_numberOfNights > 1 ? 's' : ''}",
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "${_totalPrice.toStringAsFixed(0)} CFA",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invités: $_adults adulte${_adults > 1 ? 's' : ''}${_children > 0 ? ', $_children enfant${_children > 1 ? 's' : ''}' : ''}",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              Text(
                "${_totalPrice.toStringAsFixed(0)} CFA",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int maxLines = 1,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.brown),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.brown.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.brown, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.w500),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime) onDateSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.brown,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.brown,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  bool _isFormValid() {
    bool nameValid = _nameController.text.trim().isNotEmpty;
    bool emailValid = _emailController.text.trim().isNotEmpty;
    bool phoneValid = _phoneController.text.trim().isNotEmpty;
    bool checkInValid = _checkInDate != null;
    bool checkOutValid = _checkOutDate != null;
    bool dateOrderValid =
        checkInValid && checkOutValid && _checkOutDate!.isAfter(_checkInDate!);

    // Debug - vous pouvez enlever cette ligne plus tard
    print(
      'Form validation: name=$nameValid, email=$emailValid, phone=$phoneValid, checkIn=$checkInValid, checkOut=$checkOutValid, dateOrder=$dateOrderValid',
    );

    return nameValid &&
        emailValid &&
        phoneValid &&
        checkInValid &&
        checkOutValid &&
        dateOrderValid;
  }

  void _proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      // Préparer les détails de réservation
      Map<String, dynamic> reservationDetails = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'specialRequest': _specialRequestController.text.trim(),
        'checkIn':
            _checkInDate != null
                ? "${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}"
                : "Du 25 Août",
        'checkOut':
            _checkOutDate != null
                ? "${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}"
                : "2020",
        'numberOfNights': _numberOfNights,
        'adults': _adults,
        'children': _children,
        'totalPrice': _totalPrice,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => PaymentMethodPage(
                reservationDetails: reservationDetails,
                property: widget.property,
              ),
        ),
      );
    }
  }
}
