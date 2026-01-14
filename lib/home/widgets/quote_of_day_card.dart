import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class QuoteOfDayCard extends StatelessWidget {
  final Quote quote;

  const QuoteOfDayCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2A5F),
            Color(0xFF08162F),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Quote watermark
          Positioned(
            right: -10,
            top: -20,
            child: Icon(
              Icons.format_quote,
              size: 120,
              color: Colors.white.withOpacity(0.08),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '✨ QUOTE OF THE DAY',
                style: TextStyle(
                  color: Color(0xFF6EA8FF),
                  letterSpacing: 1,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '“${quote.text}”',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '— ${quote.author}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.share, color: Colors.white70),
                  SizedBox(width: 16),
                  Icon(Icons.bookmark_border, color: Colors.white70),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
