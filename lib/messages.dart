import 'package:flutter/material.dart';
import 'widget/constants.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          backgroundColor: AppColors.primaryPink, // Pink background for AppBar
          bottom: TabBar(
            labelColor: AppColors.primaryGold, // Active tab text color
            unselectedLabelColor: Colors.black, // Inactive tab text color
            indicatorColor: AppColors.primaryGold, // Gold indicator
            labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Bold active tab
            tabs: const [
              Tab(text: 'Messagerie'),
              Tab(text: 'Notifications'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MessagerieSection(),
            NotificationsSection(),
          ],
        ),
      ),
    );
  }
}

class MessagerieSection extends StatelessWidget {
  const MessagerieSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenu de la messagerie'),
    );
  }
}

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contenu des notifications'),
    );
  }
}