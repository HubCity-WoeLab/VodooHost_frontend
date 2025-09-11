import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  int _selectedTab = 0; // 0 pour Messages, 1 pour Notifications

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // --- Titre principal ---
            const Text(
              "Inbox",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B2E2E), // marron foncé
              ),
            ),
            const SizedBox(height: 12),

            // --- Onglets Messages / Notifications ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Onglet Messages
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Messages",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    _selectedTab == 0
                                        ? const Color(0xFF6B2E2E)
                                        : Colors.grey,
                              ),
                            ),
                            if (_selectedTab == 0) ...[
                              const SizedBox(width: 4),
                              const CircleAvatar(
                                radius: 8,
                                backgroundColor: Color(0xFF6B2E2E),
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: 80,
                          color:
                              _selectedTab == 0
                                  ? const Color(0xFF6B2E2E)
                                  : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Onglet Notifications
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Column(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                _selectedTab == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                _selectedTab == 1
                                    ? const Color(0xFF6B2E2E)
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: 100,
                          color:
                              _selectedTab == 1
                                  ? const Color(0xFF6B2E2E)
                                  : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // --- Contenu selon l'onglet sélectionné ---
            Expanded(
              child:
                  _selectedTab == 0
                      ? _buildMessagesContent()
                      : _buildNotificationsContent(),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Contenu Messages ---
  Widget _buildMessagesContent() {
    return ListView(
      children: [
        _buildMessageItem(
          icon: Icons.home,
          isIcon: true,
          title: "Vodoo host",
          subtitle: "Donnez nous votre avis sur votre visite",
        ),
        _buildMessageItem(
          image: "assets/images/logement.png",
          title: "Hougno · Ouidah",
          subtitle: "Mise à jour Airbnb : réservation annulée",
          date: "Feb 13 – 14, 2023",
        ),
        _buildMessageItem(
          image: "assets/images/danse.jpg",
          title: "Erin · New York",
          subtitle: "Nouvelle demande de date et d'heure",
          date: "Demande en attente",
          highlightSubtitle: true,
        ),
      ],
    );
  }

  /// --- Contenu Notifications ---
  Widget _buildNotificationsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "Vous n'avez plus de notification",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// --- Widget message ---
  Widget _buildMessageItem({
    String? image,
    IconData? icon,
    bool isIcon = false,
    required String title,
    required String subtitle,
    String? date,
    bool highlightSubtitle = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading:
              isIcon
                  ? CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(icon, color: const Color(0xFF6B2E2E)),
                  )
                  : CircleAvatar(backgroundImage: AssetImage(image!)),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      highlightSubtitle ? FontWeight.bold : FontWeight.normal,
                  color:
                      highlightSubtitle
                          ? const Color(0xFF6B2E2E)
                          : Colors.black87,
                ),
              ),
              if (date != null)
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
