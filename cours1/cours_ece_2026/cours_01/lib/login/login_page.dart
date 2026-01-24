import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in or sign up',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const EmailField(),
              const SizedBox(height: 20),
              ContinueButton(onPressed: () {}),
              const OrSeparator(),
              SocialContinueButton(
                label: 'Apple',
                assetPath: 'assets/apple_logo.svg',
                onPressed: () {},
              ),
              SocialContinueButton(
                label: 'Google',
                assetPath: 'assets/google_logo.svg',
                onPressed: () {},
              ),
              SocialContinueButton(
                label: 'Facebook',
                assetPath: 'assets/facebook_logo.svg',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
        hintText: 'Email Address',
        hintStyle: const TextStyle(color: Color(0xFFCBD5E0)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF5390A4)),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ContinueButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF5390A4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          Expanded(child: Divider(color: Color(0xFFE2E8F0))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Or', style: TextStyle(color: Color(0xFF718096))),
          ),
          Expanded(child: Divider(color: Color(0xFFE2E8F0))),
        ],
      ),
    );
  }
}

class SocialContinueButton extends StatelessWidget {
  final String label;
  final String assetPath;
  final VoidCallback onPressed;

  const SocialContinueButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetPath, height: 24),
            const SizedBox(width: 12),
            Text(
              'Continue with $label',
              style: const TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}