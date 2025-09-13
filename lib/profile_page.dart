import 'package:flutter/material.dart';
import 'favorites.dart';
import 'payment_method.dart';
import 'edit_profile.dart';
import 'my_stays.dart';
import 'settings.dart';
import 'help.dart';
import 'dashboard.dart';
import 'privacy_policy.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Color(0xFF884B4B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF884B4B)),
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Section profil utilisateur
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/111.jpeg"),
                  backgroundColor: Color(0xFF884B4B),
                ),
                const SizedBox(height: 16),
                const Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF884B4B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Menu sections
            _buildMenuSection("Mon Compte", [
              _buildMenuItem(
                Icons.person_outline,
                "Informations personnelles",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                ),
              ),
              _buildMenuItem(
                Icons.favorite_outline,
                "Favoris",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavorisPage()),
                ),
              ),
              _buildMenuItem(
                Icons.hotel_outlined,
                "Mes Séjours",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyStaysPage()),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            _buildMenuSection("Paiement", [
              _buildMenuItem(
                Icons.credit_card_outlined,
                "Méthodes de paiement",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodPage(),
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            _buildMenuSection("Paramètres", [
              _buildMenuItem(
                Icons.settings_outlined,
                "Paramètres",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                ),
              ),
              _buildMenuItem(
                Icons.privacy_tip_outlined,
                "Politique de confidentialité",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                ),
              ),
              _buildMenuItem(
                Icons.help_outline,
                "Aide",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            _buildMenuSection("", [
              _buildMenuItem(
                Icons.dashboard_outlined,
                "Tableau de bord",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                ),
              ),
              _buildMenuItem(
                Icons.logout,
                "Déconnexion",
                () => _showLogoutDialog(context),
                textColor: Colors.red,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF884B4B),
                ),
              ),
            ),
            const Divider(height: 1),
          ],
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF884B4B).withOpacity(0.2),
        child: Icon(
          icon,
          color: textColor ?? const Color(0xFF884B4B),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Déconnexion",
            style: TextStyle(
              color: Color(0xFF884B4B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement logout logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Déconnexion réussie"),
                    backgroundColor: Color(0xFF884B4B),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Déconnecter"),
            ),
          ],
        );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec avatar et nom
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            accountName: const Text(
              "John",
              style: TextStyle(
                color: Color(0xFF884B4B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: null,
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/111.jpeg"),
            ),
          ),

          // Liste des menus
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  icon: Icons.person,
                  text: "Profile",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.favorite,
                  text: "Favoris",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavorisPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.credit_card,
                  text: "Methode De Payment",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentMethodPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.privacy_tip,
                  text: "Politique De Confidentialité",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.settings,
                  text: "Paramètre",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.help_outline,
                  text: "Aide",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpPage()),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.hotel,
                  text: "Mes Séjours",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyStaysPage(),
                      ),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.logout,
                  text: "Déconnexion",
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
                DrawerItem(
                  icon: Icons.dashboard,
                  text: "Tableau De Bord",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Déconnexion",
            style: TextStyle(
              color: Color(0xFF884B4B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Annuler",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement logout logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Déconnexion réussie"),
                    backgroundColor: Color(0xFF884B4B),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Déconnecter"),
            ),
          ],
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF884B4B).withOpacity(0.2),
        child: Icon(icon, color: const Color(0xFF884B4B)),
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }
}
