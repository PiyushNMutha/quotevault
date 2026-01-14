import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_provider.dart';
import 'widgets/settings_tile.dart';
import 'widgets/preview_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return profileAsync.when(
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF0B1220),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text(e.toString())),
      ),
      data: (p) {
        return Scaffold(
          backgroundColor: const Color(0xFF0B1220),
          appBar: AppBar(
            title: const Text('Settings & Preferences'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Profile Header
              Row(
                children: [
                  const CircleAvatar(radius: 28),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(p.email,
                          style: const TextStyle(color: Colors.white60)),
                      const SizedBox(height: 4),
                      const Text('✔ PREMIUM MEMBER',
                          style: TextStyle(
                              color: Color(0xFF1A5CFF),
                              fontSize: 12)),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),
              const Text('APPEARANCE',
                  style: TextStyle(color: Colors.white54)),

              SwitchListTile(
                value: p.theme == 'dark',
                onChanged: (v) => ref
                    .read(profileProvider.notifier)
                    .updateTheme(v),
                title: const Text('Dark Mode',
                    style: TextStyle(color: Colors.white)),
              ),

              PreviewCard(fontSize: p.fontSize),

              Slider(
                min: 14,
                max: 28,
                value: p.fontSize.toDouble(),
                onChanged: (v) => ref
                    .read(profileProvider.notifier)
                    .updateFontSize(v),
              ),

              const SizedBox(height: 20),
              const Text('GENERAL PREFERENCES',
                  style: TextStyle(color: Colors.white54)),

              SettingsTile(
                icon: Icons.notifications,
                title: 'Notifications',
                value: p.notifications ? 'On' : 'Off',
                onTap: () => ref
                    .read(profileProvider.notifier)
                    .updateNotifications(!p.notifications),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                ),
                onPressed: () => ref
                    .read(profileProvider.notifier)
                    .signOut(),
                child: const Text('Sign Out'),
              ),

              const SizedBox(height: 12),
              Text(
                'Joined QuoteVault on ${p.joinedDate.month}/${p.joinedDate.year}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white38),
              ),
            ],
          ),
        );
      },
    );
  }
}
