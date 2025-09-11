import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vodoo_host/bottomNav.dart';
import 'widget/constants.dart';
import 'widget/custom_text_form_field.dart';
import 'home_hote.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyOtp(String otpCode) async {
    final url = Uri.parse(AppConstants.otpcode);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'otp': otpCode});

    try {
      final response = await http.post(url, headers: headers, body: body);
      log('Status code: ${response.statusCode}');
      log('Response: ${response.body}');

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['accessToken'] != null) {
        final int? roleId = responseData['role'];
        String role = '';

        if (roleId == 1) {
          role = 'visiteur';
        } else if (roleId == 2) {
          role = 'hôte';
        } else {
          log('Rôle inconnu ou role_id manquant : $roleId');
        }

        if (role.isEmpty) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rôle inconnu ou non pris en charge : $roleId')),
          );
          return;
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP vérifié avec succès !')),
        );

        if (role == 'visiteur') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
          );
        } else if (role == 'hôte') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeHotePage()),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la vérification : ${response.body}')),
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
        title: const Text('Code OTP'),
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
                    const Text(
                      'Veuillez entrer le code OTP envoyé à votre email',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          child: CustomTextFormField(
                            controller: _otpControllers[index],
                            hintText: '*',
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            borderRadius: 15,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final otpCode = _otpControllers
                                .map((controller) => controller.text)
                                .join();
                            verifyOtp(otpCode);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Vérifier le code OTP',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
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