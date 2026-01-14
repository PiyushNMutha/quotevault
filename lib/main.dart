import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://janckiorrydqgjpwdvqr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImphbmNraW9ycnlkcWdqcHdkdnFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzNjcwNTksImV4cCI6MjA4Mzk0MzA1OX0.gbWMu_R5LrZKvqDwC0Xb9DBj3R2mf8m4sKUV7BGw1z4',
  );

  runApp(
    const ProviderScope(
      child: QuoteVaultApp(),
    ),
  );
}

class QuoteVaultApp extends StatelessWidget {
  const QuoteVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuoteVault',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const AuthGate(),
    );
  }
}
