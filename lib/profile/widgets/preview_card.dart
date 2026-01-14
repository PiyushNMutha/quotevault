import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final int fontSize;

  const PreviewCard({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121E32),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'PREVIEW',
            style: TextStyle(
              color: Color(0xFF1A5CFF),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '“The only way to do great work is to love what you do.”',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize.toDouble(),
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '— Steve Jobs',
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
