import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/language_button.dart';
import 'shopping_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final strings = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 42),
        title: Text(strings.successTitle),
        content: Text(strings.accountCreated),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushReplacement(
                PageRouteBuilder<void>(
                  transitionDuration: const Duration(milliseconds: 650),
                  pageBuilder: (_, animation, secondaryAnimation) =>
                      ShoppingScreen(onLocaleChanged: widget.onLocaleChanged),
                  transitionsBuilder:
                      (_, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            child: Text(strings.continueButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.signUpTitle),
        actions: [
          LanguageButton(onLocaleChanged: widget.onLocaleChanged),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width > 600 ? 480 : 480),
            child: Card(
              elevation: 1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.person_add_alt_1,
                          size: 54, color: Color(0xFF5B4BDB)),
                      const SizedBox(height: 12),
                      Text(
                        strings.createAccount,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _fullNameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: strings.fullName,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          final name = value?.trim() ?? '';
                          if (name.isEmpty) return strings.nameRequired;
                          if (!RegExp(r'^[A-Z][a-zA-Z]*(?:\s+[A-Z][a-zA-Z]*)*$')
                              .hasMatch(name)) {
                            return strings.nameInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: strings.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) return strings.emailRequired;
                          if (!email.contains('@')) return strings.emailInvalid;
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: strings.password,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return strings.passwordRequired;
                          }
                          if (value.length < 6) return strings.passwordShort;
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: strings.confirmPassword,
                          prefixIcon: const Icon(Icons.lock_reset),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return strings.confirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return strings.passwordMismatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _submitForm,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: Text(strings.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
