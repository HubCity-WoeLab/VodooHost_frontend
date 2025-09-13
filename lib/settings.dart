import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _pushNotifications = true;
  bool _darkModeEnabled = false;
  String _language = 'Français';
  String _currency = 'FCFA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF884B4B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Paramètres",
          style: TextStyle(
            color: Color(0xFF884B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Notifications
            _buildSectionTitle("Notifications"),
            _buildSwitchTile(
              "Notifications",
              "Recevoir toutes les notifications",
              _notificationsEnabled,
              (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              icon: Icons.notifications_outlined,
            ),

            if (_notificationsEnabled) ...[
              _buildSwitchTile(
                "Notifications Email",
                "Recevoir les notifications par email",
                _emailNotifications,
                (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
                icon: Icons.email_outlined,
                isSubSetting: true,
              ),

              _buildSwitchTile(
                "Notifications SMS",
                "Recevoir les notifications par SMS",
                _smsNotifications,
                (value) {
                  setState(() {
                    _smsNotifications = value;
                  });
                },
                icon: Icons.sms_outlined,
                isSubSetting: true,
              ),

              _buildSwitchTile(
                "Notifications Push",
                "Recevoir les notifications push",
                _pushNotifications,
                (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
                icon: Icons.phone_android_outlined,
                isSubSetting: true,
              ),
            ],

            const SizedBox(height: 24),

            // Section Apparence
            _buildSectionTitle("Apparence"),
            _buildSwitchTile(
              "Mode Sombre",
              "Activer le thème sombre",
              _darkModeEnabled,
              (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
              icon: Icons.dark_mode_outlined,
            ),

            const SizedBox(height: 24),

            // Section Langue et Région
            _buildSectionTitle("Langue et Région"),
            _buildSelectionTile(
              "Langue",
              _language,
              Icons.language_outlined,
              () => _showLanguageDialog(),
            ),

            _buildSelectionTile(
              "Devise",
              _currency,
              Icons.attach_money_outlined,
              () => _showCurrencyDialog(),
            ),

            const SizedBox(height: 24),

            // Section Compte
            _buildSectionTitle("Compte"),
            _buildActionTile(
              "Changer le mot de passe",
              "Modifier votre mot de passe",
              Icons.lock_outline,
              () => _showChangePasswordDialog(),
            ),

            _buildActionTile(
              "Supprimer le compte",
              "Supprimer définitivement votre compte",
              Icons.delete_outline,
              () => _showDeleteAccountDialog(),
              textColor: Colors.red,
            ),

            const SizedBox(height: 24),

            // Section À propos
            _buildSectionTitle("À propos"),
            _buildActionTile(
              "Conditions d'utilisation",
              "Consultez nos conditions d'utilisation",
              Icons.description_outlined,
              () {},
            ),

            _buildActionTile(
              "Version de l'application",
              "v1.0.0",
              Icons.info_outline,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF884B4B),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged, {
    required IconData icon,
    bool isSubSetting = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: isSubSetting ? 20 : 0),
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
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isSubSetting ? 14 : 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSubSetting ? 12 : 14,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF884B4B),
        secondary: Icon(icon, color: const Color(0xFF884B4B)),
      ),
    );
  }

  Widget _buildSelectionTile(
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF884B4B)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey.shade600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        leading: Icon(icon, color: textColor ?? const Color(0xFF884B4B)),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choisir la langue"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text("Français"),
                value: "Français",
                groupValue: _language,
                activeColor: const Color(0xFF884B4B),
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text("English"),
                value: "English",
                groupValue: _language,
                activeColor: const Color(0xFF884B4B),
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choisir la devise"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text("FCFA"),
                value: "FCFA",
                groupValue: _currency,
                activeColor: const Color(0xFF884B4B),
                onChanged: (value) {
                  setState(() {
                    _currency = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text("EUR"),
                value: "EUR",
                groupValue: _currency,
                activeColor: const Color(0xFF884B4B),
                onChanged: (value) {
                  setState(() {
                    _currency = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text("USD"),
                value: "USD",
                groupValue: _currency,
                activeColor: const Color(0xFF884B4B),
                onChanged: (value) {
                  setState(() {
                    _currency = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    // TODO: Implémenter le changement de mot de passe
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fonctionnalité de changement de mot de passe à venir"),
        backgroundColor: Color(0xFF884B4B),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Supprimer le compte",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Cette action est irréversible. Toutes vos données seront définitivement supprimées.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implémenter la suppression du compte
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Supprimer"),
            ),
          ],
        );
      },
    );
  }
}
