import 'package:flutter/material.dart';
import 'widget/constants.dart';

class AvailabilityPage extends StatefulWidget {
  final Map<String, dynamic> property;

  const AvailabilityPage({super.key, required this.property});

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  DateTime selectedMonth = DateTime.now();
  DateTime? checkInDate;
  DateTime? checkOutDate;

  // Dates non disponibles simulées
  final Set<DateTime> unavailableDates = {
    DateTime(2025, 1, 15),
    DateTime(2025, 1, 16),
    DateTime(2025, 1, 22),
    DateTime(2025, 1, 23),
    DateTime(2025, 1, 24),
    DateTime(2025, 2, 8),
    DateTime(2025, 2, 9),
    DateTime(2025, 2, 14),
    DateTime(2025, 2, 15),
    DateTime(2025, 2, 16),
    DateTime(2025, 2, 28),
    DateTime(2025, 3, 1),
    DateTime(2025, 3, 2),
    DateTime(2025, 3, 15),
    DateTime(2025, 3, 16),
    DateTime(2025, 3, 22),
    DateTime(2025, 3, 23),
  };

  final List<String> months = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre',
  ];

  final List<String> weekDays = [
    'Lun',
    'Mar',
    'Mer',
    'Jeu',
    'Ven',
    'Sam',
    'Dim',
  ];

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
          'Disponibilité',
          style: TextStyle(
            color: AppColors.secondaryRed,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // SÉLECTEUR DE MOIS
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedMonth = DateTime(
                        selectedMonth.year,
                        selectedMonth.month - 1,
                      );
                    });
                  },
                  icon: Icon(Icons.chevron_left, color: AppColors.secondaryRed),
                ),
                Text(
                  '${months[selectedMonth.month - 1]} ${selectedMonth.year}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryRed,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedMonth = DateTime(
                        selectedMonth.year,
                        selectedMonth.month + 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    color: AppColors.secondaryRed,
                  ),
                ),
              ],
            ),
          ),

          // CALENDRIER
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // En-têtes des jours
                  Row(
                    children:
                        weekDays
                            .map(
                              (day) => Expanded(
                                child: Center(
                                  child: Text(
                                    day,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 8),

                  // Grille du calendrier
                  Expanded(child: _buildCalendarGrid()),
                ],
              ),
            ),
          ),

          // LÉGENDE
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildLegendItem(
                      color: AppColors.primaryPink.withOpacity(0.3),
                      label: 'Arrivée',
                    ),
                    const SizedBox(width: 16),
                    _buildLegendItem(
                      color: AppColors.primaryGold.withOpacity(0.3),
                      label: 'Départ',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildLegendItem(
                      color: Colors.grey.shade300,
                      label: 'Non disponible',
                    ),
                    const SizedBox(width: 16),
                    _buildLegendItem(
                      color: Colors.white,
                      label: 'Disponible',
                      border: true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // BOUTON DE RÉSERVATION
          if (checkInDate != null && checkOutDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Arrivée: ${_formatDate(checkInDate!)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryRed,
                          ),
                        ),
                        Text(
                          'Départ: ${_formatDate(checkOutDate!)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBookingConfirmation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Réserver ces dates',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    DateTime firstDayOfMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month,
      1,
    );
    DateTime lastDayOfMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      0,
    );
    int daysInMonth = lastDayOfMonth.day;
    int firstWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: daysInMonth + firstWeekday - 1,
      itemBuilder: (context, index) {
        if (index < firstWeekday - 1) {
          return Container(); // Cases vides pour les jours du mois précédent
        }

        int day = index - firstWeekday + 2;
        DateTime currentDate = DateTime(
          selectedMonth.year,
          selectedMonth.month,
          day,
        );
        bool isUnavailable = unavailableDates.contains(currentDate);
        bool isPast = currentDate.isBefore(DateTime.now());
        bool isCheckIn =
            checkInDate != null && _isSameDay(currentDate, checkInDate!);
        bool isCheckOut =
            checkOutDate != null && _isSameDay(currentDate, checkOutDate!);
        bool isInRange =
            checkInDate != null &&
            checkOutDate != null &&
            currentDate.isAfter(checkInDate!) &&
            currentDate.isBefore(checkOutDate!);

        Color? backgroundColor;
        Color? borderColor;
        Color textColor = Colors.black87;

        if (isPast || isUnavailable) {
          backgroundColor = Colors.grey.shade300;
          textColor = Colors.grey.shade600;
        } else if (isCheckIn) {
          backgroundColor = AppColors.primaryPink.withOpacity(0.3);
          borderColor = AppColors.primaryPink;
        } else if (isCheckOut) {
          backgroundColor = AppColors.primaryGold.withOpacity(0.3);
          borderColor = AppColors.primaryGold;
        } else if (isInRange) {
          backgroundColor = AppColors.secondaryBeige.withOpacity(0.2);
        }

        return GestureDetector(
          onTap:
              (isPast || isUnavailable) ? null : () => _selectDate(currentDate),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: backgroundColor,
              border:
                  borderColor != null
                      ? Border.all(color: borderColor, width: 2)
                      : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: textColor,
                  fontWeight:
                      (isCheckIn || isCheckOut)
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    bool border = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            border: border ? Border.all(color: Colors.grey.shade400) : null,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  void _selectDate(DateTime date) {
    setState(() {
      if (checkInDate == null || (checkOutDate != null)) {
        // Première sélection ou nouvelle sélection
        checkInDate = date;
        checkOutDate = null;
      } else if (date.isBefore(checkInDate!)) {
        // Date sélectionnée avant la date d'arrivée
        checkInDate = date;
        checkOutDate = null;
      } else {
        // Sélection de la date de départ
        checkOutDate = date;
      }
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showBookingConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.primaryGold,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Confirmer la réservation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryRed,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Du ${_formatDate(checkInDate!)} au ${_formatDate(checkOutDate!)}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '${checkOutDate!.difference(checkInDate!).inDays} nuits',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.secondaryRed),
                        ),
                        child: Text(
                          'Annuler',
                          style: TextStyle(color: AppColors.secondaryRed),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Réservation confirmée !'),
                              backgroundColor: AppColors.secondaryRed,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryRed,
                        ),
                        child: const Text(
                          'Confirmer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
