import 'package:flutter/material.dart';
import 'guest_selection.dart';

class DateSelectionPage extends StatefulWidget {
  final String destination;

  const DateSelectionPage({super.key, required this.destination});

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _endDay;
  int _flexibility = 0;
  int _selectedChoice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header moderne
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
                  // Barre de navigation
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.brown),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          "Quand partez-vous ?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Destination sélectionnée
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.brown.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          widget.destination,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Options de sélection
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildModernChoiceChip("Dates", 0, Icons.calendar_today),
                    const SizedBox(width: 12),
                    _buildModernChoiceChip("Mois", 1, Icons.date_range),
                    const SizedBox(width: 12),
                    _buildModernChoiceChip("Flexible", 2, Icons.schedule),
                    const SizedBox(width: 12),
                    _buildModernChoiceChip("Weekend", 3, Icons.weekend),
                    const SizedBox(width: 12),
                    _buildModernChoiceChip("Semaine", 4, Icons.view_week),
                  ],
                ),
              ),
            ),

            // Contenu principal
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
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
                child: _buildModernContent(),
              ),
            ),

            // Section flexibilité pour les dates
            if (_selectedChoice == 0)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Flexibilité des dates",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFlexibilityButton("Exactes", 0),
                        _buildFlexibilityButton("± 1 jour", 1),
                        _buildFlexibilityButton("± 2 jours", 2),
                      ],
                    ),
                  ],
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
                      onPressed: () => Navigator.pop(context),
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
                    child: ElevatedButton(
                      onPressed: () {
                        // Naviguer vers la page de sélection des voyageurs
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => GuestSelectionPage(
                                  destination: widget.destination,
                                  selectedDay: _selectedDay,
                                  endDay: _endDay,
                                  choice: _selectedChoice,
                                  flexibility: _flexibility,
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Suivant",
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

  Widget _buildModernChoiceChip(String label, int index, IconData icon) {
    final isSelected = _selectedChoice == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChoice = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.brown : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.brown,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.brown,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlexibilityButton(String label, int value) {
    final isSelected = _flexibility == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _flexibility = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.brown : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.brown,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernContent() {
    switch (_selectedChoice) {
      case 0:
        return _buildModernCalendar();
      case 1:
        return _buildModernMonthSelection();
      case 2:
        return _buildModernFlexibleOptions();
      case 3:
        return _buildModernWeekendOptions();
      case 4:
        return _buildModernWeekOptions();
      default:
        return _buildModernCalendar();
    }
  }

  Widget _buildModernCalendar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // En-tête du calendrier
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                    );
                  });
                },
                icon: const Icon(Icons.chevron_left, color: Colors.brown),
              ),
              Text(
                "${_getMonthName(_focusedDay.month)} ${_focusedDay.year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                    );
                  });
                },
                icon: const Icon(Icons.chevron_right, color: Colors.brown),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Jours de la semaine
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                    .map(
                      (day) => Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),

          const SizedBox(height: 10),

          // Grille de dates (simplifiée)
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 35,
              itemBuilder: (context, index) {
                final day = index + 1;
                final isToday =
                    day == DateTime.now().day &&
                    _focusedDay.month == DateTime.now().month;
                final isSelected =
                    _selectedDay?.day == day &&
                    _selectedDay?.month == _focusedDay.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month,
                        day,
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.brown
                              : isToday
                              ? Colors.brown.shade100
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          isToday && !isSelected
                              ? Border.all(color: Colors.brown)
                              : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : isToday
                                ? Colors.brown
                                : Colors.black,
                        fontWeight:
                            isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Information de sélection
          if (_selectedDay != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Date sélectionnée: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}",
                style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernMonthSelection() {
    final months = [
      "Janvier",
      "Février",
      "Mars",
      "Avril",
      "Mai",
      "Juin",
      "Juillet",
      "Août",
      "Septembre",
      "Octobre",
      "Novembre",
      "Décembre",
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sélectionnez un mois",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: months.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedDay?.month == index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = DateTime(
                        DateTime.now().year,
                        index + 1,
                        1,
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.brown : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.brown : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      months[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.brown,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFlexibleOptions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 64, color: Colors.brown.shade300),
          const SizedBox(height: 20),
          const Text(
            "Dates flexibles",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "N'importe quand dans les 3 prochains mois",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildModernWeekendOptions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Weekends disponibles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final weekend = DateTime.now().add(
                  Duration(days: 7 * (index + 1)),
                );
                final saturday = weekend.subtract(
                  Duration(days: weekend.weekday - 6),
                );
                final sunday = saturday.add(const Duration(days: 1));
                final isSelected = _selectedDay?.day == saturday.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = saturday;
                      _endDay = sunday;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.brown.shade50
                              : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.brown : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.weekend,
                          color:
                              isSelected ? Colors.brown : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weekend ${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.brown : Colors.black,
                                ),
                              ),
                              Text(
                                "${saturday.day}/${saturday.month} - ${sunday.day}/${sunday.month}",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle, color: Colors.brown),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernWeekOptions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Semaines disponibles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final startWeek = DateTime.now().add(
                  Duration(days: 7 * (index + 1)),
                );
                final endWeek = startWeek.add(const Duration(days: 6));
                final isSelected = _selectedDay?.day == startWeek.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = startWeek;
                      _endDay = endWeek;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.brown.shade50
                              : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.brown : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.view_week,
                          color:
                              isSelected ? Colors.brown : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Semaine ${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.brown : Colors.black,
                                ),
                              ),
                              Text(
                                "${startWeek.day}/${startWeek.month} - ${endWeek.day}/${endWeek.month}",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle, color: Colors.brown),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Janvier",
      "Février",
      "Mars",
      "Avril",
      "Mai",
      "Juin",
      "Juillet",
      "Août",
      "Septembre",
      "Octobre",
      "Novembre",
      "Décembre",
    ];
    return months[month - 1];
  }
}
