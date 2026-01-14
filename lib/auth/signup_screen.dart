import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = AuthService();

  bool _loading = false;

  Future<void> _signup() async {
    setState(() => _loading = true);
    try {
      await _auth.signUp(
        name: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      Navigator.pop(context);
    } catch (e) {
      _showError(e.toString());
    }
    setState(() => _loading = false);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1625),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AuthTextField(
              label: 'Full Name',
              hint: 'John Doe',
              controller: _name,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              label: 'Email Address',
              hint: 'name@example.com',
              controller: _email,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              label: 'Password',
              hint: '••••••••',
              controller: _password,
              obscure: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _loading ? null : _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A5CFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
