import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import 'login.dart';
import 'otp.dart';
import 'widget/constants.dart';
import 'widget/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();
  String? completePhoneNumber;
  int? selectedRoleId;
  bool acceptTerms = false;
  bool _isPasswordVisible = false;

  Future<void> registerUser(String nom, String prenom, String email, String motDePasse, String telephone, int roleId) async {
    final url = Uri.parse(AppConstants.register);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'mot_de_passe': motDePasse,
      'telephone': telephone,
      'role_id': roleId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Utilisateur enregistré avec succès !')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtpPage()),
        );
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'enregistrement : ${response.body}')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              child: Image.asset(
                "assets/images/danse.jpg",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Bienvenue sur notre application !',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: nomController,
                      hintText: 'Entrez votre nom',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: prenomController,
                      hintText: 'Entrez votre prénom',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre prénom';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Entrez votre email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: motDePasseController,
                      hintText: 'Entrez votre mot de passe',
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Entrez votre numéro de téléphone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      initialCountryCode: 'FR',
                      onChanged: (phone) {
                        completePhoneNumber = phone.completeNumber;
                      },
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return 'Veuillez entrer votre numéro de téléphone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedRoleId,
                      decoration: InputDecoration(
                        hintText: 'Sélectionnez votre rôle',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Hôte'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Visiteur'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRoleId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner un rôle';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          acceptTerms = value ?? false;
                        });
                      },
                      title: const Text(
                        "J'accepte les termes et conditions",
                        style: TextStyle(fontSize: 14),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && acceptTerms) {
                            registerUser(
                              nomController.text,
                              prenomController.text,
                              emailController.text,
                              motDePasseController.text,
                              completePhoneNumber!,
                              selectedRoleId!,
                            );
                          } else if (!acceptTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Veuillez accepter les termes.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'S\'inscrire',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Vous avez déjà un compte ? Connectez-vous",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}