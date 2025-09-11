import 'package:flutter/material.dart';

class GuestSelectionPage extends StatefulWidget {
  final String destination;
  final DateTime? selectedDay;
  final DateTime? endDay;
  final int choice;
  final int flexibility;

  const GuestSelectionPage({
    super.key,
    required this.destination,
    this.selectedDay,
    this.endDay,
    required this.choice,
    required this.flexibility,
  });

  @override
  State<GuestSelectionPage> createState() => _GuestSelectionPageState();
}

class _GuestSelectionPageState extends State<GuestSelectionPage> {
  int adults = 1;
  int children = 0;
  int infants = 0;
  int pets = 0;

  Widget _buildCounter(
    String title,
    String subtitle,
    int value,
    VoidCallback onAdd,
    VoidCallback onRemove,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: value > 0 ? Colors.brown : Colors.grey.shade400,
                ),
                onPressed: value > 0 ? onRemove : null,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  "$value",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
                onPressed: onAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day}/${date.month}/${date.year}";
  }

  String _getDateRange() {
    if (widget.selectedDay == null) return "Date non sélectionnée";

    if (widget.endDay != null) {
      return "${_formatDate(widget.selectedDay)} - ${_formatDate(widget.endDay)}";
    } else {
      return _formatDate(widget.selectedDay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Navigation bar
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.brown),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Séjours",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "Experiences",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.brown),
                        onPressed:
                            () => Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenu principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    // Champ Où
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.brown.shade200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Où",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.destination,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Champ Quand
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.brown.shade200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quand ?",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            _getDateRange(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section Qui vient ?
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Qui vient ?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 20),

                          _buildCounter(
                            "Adultes",
                            "13 ans ou plus",
                            adults,
                            () {
                              setState(() => adults++);
                            },
                            () {
                              if (adults > 1) setState(() => adults--);
                            },
                          ),

                          Divider(color: Colors.grey.shade200),

                          _buildCounter(
                            "Enfants",
                            "2 à 12 ans",
                            children,
                            () {
                              setState(() => children++);
                            },
                            () {
                              if (children > 0) setState(() => children--);
                            },
                          ),

                          Divider(color: Colors.grey.shade200),

                          _buildCounter(
                            "Nourrissons",
                            "Moins de 2 ans",
                            infants,
                            () {
                              setState(() => infants++);
                            },
                            () {
                              if (infants > 0) setState(() => infants--);
                            },
                          ),

                          Divider(color: Colors.grey.shade200),

                          _buildCounter(
                            "Animaux de compagnie",
                            "Vous amenez un animal ?",
                            pets,
                            () {
                              setState(() => pets++);
                            },
                            () {
                              if (pets > 0) setState(() => pets--);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Résumé
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.brown.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Résumé de votre recherche",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${adults + children + infants} voyageur${(adults + children + infants) > 1 ? 's' : ''}",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          if (pets > 0)
                            Text(
                              "$pets animal${pets > 1 ? 'aux' : ''} de compagnie",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Boutons d'action
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          () => Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.brown),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Annuler",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        // Retourner toutes les données sélectionnées
                        Map<String, dynamic> result = {
                          'destination': widget.destination,
                          'selectedDay': widget.selectedDay,
                          'endDay': widget.endDay,
                          'choice': widget.choice,
                          'flexibility': widget.flexibility,
                          'adults': adults,
                          'children': children,
                          'infants': infants,
                          'pets': pets,
                        };
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pop(context, result);
                      },
                      icon: const Icon(Icons.search, color: Colors.white),
                      label: const Text(
                        "Rechercher",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
