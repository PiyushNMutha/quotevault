import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../favorites/providers/favorites_provider.dart';
import '../models/quote_model.dart';
import '../../core/utils/share_quote_image.dart';
import 'package:share_plus/share_plus.dart';

class QuoteDetailScreen extends ConsumerWidget {
  final Quote quote;

  const QuoteDetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);
    final favorites = favoritesAsync.value ?? {};
    final isFavorite = favorites.contains(quote.id);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B1220),
              Color(0xFF020409),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              /// 🔙 Back Button
              Positioned(
                top: 16,
                left: 16,
                child: _CircleButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ),

              // /// ⋮ More Button
              // Positioned(
              //   top: 16,
              //   right: 16,
              //   child: _CircleButton(
              //     icon: Icons.more_horiz,
              //     onTap: () {},
              //   ),
              // ),

              /// Main Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Category Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF102A5F),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        quote.category.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF1A5CFF),
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    /// Quote Text
                    Text(
                      '“${quote.text}”',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Author
                    Text(
                      '— ${quote.author}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              /// Bottom Action Bar
              Positioned(
                bottom: 30,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// ❤️ Favorite
                      _ActionButton(
                        icon: isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: 'Favorite',
                        onTap: () => ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(quote.id),
                      ),

                      /// 📤 Share
                      _ActionButton(
                        icon: Icons.share,
                        label: 'Share',
                        onTap: () async {
                          await Share.share(
                            '"${quote.text}"\n— ${quote.author}',
                          );
                        },
                      ),

                      /// 📋 Copy
                      _ActionButton(
                        icon: Icons.copy,
                        label: 'Copy',
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text:
                              '"${quote.text}" — ${quote.author}',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to clipboard'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1F2937),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
