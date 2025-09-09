import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_links/app_links.dart';
import 'widget/constants.dart';
import 'widget/custom_text_form_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmailSent = false;
  String? token;
  late final AppLinks _appLinks;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _processLink(initialLink.toString());
      }

      _appLinks.uriLinkStream.listen((Uri? link) {
        if (link != null) {
          _processLink(link.toString());
        }
      });
    } catch (e) {
      debugPrint('Erreur lors du traitement des liens : $e');
    }
  }

  void _processLink(String link) {
    final uri = Uri.parse(link);
    if (uri.host == 'resetpassword' && uri.queryParameters.containsKey('token')) {
      setState(() {
        token = uri.queryParameters['token'];
      });
    }
  }

  Future<void> sendForgotPasswordRequest(String email) async {
    final url = Uri.parse(AppConstants.forgotPassword);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (!mounted) return;
      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Lien envoyé avec succès.')),
        );
        setState(() {
          isEmailSent = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${responseBody['message'] ?? response.body}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    final url = Uri.parse(AppConstants.resetPassword);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'token': token, 'mot_de_passe': newPassword});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (!mounted) return;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mot de passe réinitialisé avec succès !')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${response.body}')),
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
        title: Text(isEmailSent ? 'Réinitialiser le mot de passe' : 'Mot de passe oublié'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isEmailSent) ...[
                      const Text(
                        'Entrez votre email pour recevoir un lien de réinitialisation.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendForgotPasswordRequest(_emailController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Envoyer',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ] else if (token != null) ...[
                      const Text(
                        'Entrez votre nouveau mot de passe.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Nouveau mot de passe',
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
                            return 'Veuillez entrer un mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirmez le mot de passe',
                        obscureText: !_isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez confirmer votre mot de passe';
                          }
                          if (value != _passwordController.text) {
                            return 'Les mots de passe ne correspondent pas';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              resetPassword(token!, _passwordController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Réinitialiser',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ] else ...[
                      const Center(child: Text('Aucun token trouvé.')),
                    ],
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