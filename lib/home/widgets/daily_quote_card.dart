import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../screens/quote_detail_screen.dart';

class DailyQuoteCard extends StatelessWidget {
  final Quote quote;

  const DailyQuoteCard({super.key, required this.quote});

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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF121E32),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '“${quote.text}”',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              quote.author.toUpperCase(),
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.favorite_border,
                    color: Colors.white54, size: 20),
                SizedBox(width: 16),
                Icon(Icons.share,
                    color: Colors.white54, size: 20),
                SizedBox(width: 16),
                Icon(Icons.bookmark_border,
                    color: Colors.white54, size: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
