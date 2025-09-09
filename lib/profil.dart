import 'package:flutter/material.dart';
import 'widget/constants.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nom d\'utilisateur',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'email@example.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier le profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle logout logic
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Se déconnecter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink, // Use your provided color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}