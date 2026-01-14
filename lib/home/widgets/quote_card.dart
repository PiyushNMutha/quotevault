import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../screens/quote_detail_screen.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final bool isFeatured;

  const QuoteCard({
    super.key,
    required this.quote,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuoteDetailScreen(quote: quote),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: isFeatured
              ? const LinearGradient(
            colors: [Color(0xFF0F2A5F), Color(0xFF08162F)],
          )
              : null,
          color: isFeatured ? null : const Color(0xFF121E32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '“${quote.text}”',
              style: TextStyle(
                fontSize: isFeatured ? 22 : 18,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '— ${quote.author}',
              style: const TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
