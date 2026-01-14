import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_repository.dart';

final profileProvider =
AsyncNotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);

class ProfileState {
  final String name;
  final String email;
  final String theme;
  final int fontSize;
  final bool notifications;
  final DateTime joinedDate;

  ProfileState({
    required this.name,
    required this.email,
    required this.theme,
    required this.fontSize,
    required this.notifications,
    required this.joinedDate,
  });
}

class ProfileNotifier extends AsyncNotifier<ProfileState> {
  final repo = ProfileRepository();

  @override
  Future<ProfileState> build() async {
    final data = await repo.fetchProfile();

    return ProfileState(
      name: data['name'],
      email: data['email'] ?? '',
      theme: data['theme'] ?? 'dark',
      fontSize: data['font_size'] ?? 18,
      notifications: data['notifications_enabled'] ?? true,
      joinedDate: DateTime.parse(data['created_at']),
    );
  }

  Future<void> updateTheme(bool isDark) async {
    await repo.updateProfile({'theme': isDark ? 'dark' : 'light'});
    state = await AsyncValue.guard(build);
  }

  Future<void> updateFontSize(double size) async {
    await repo.updateProfile({'font_size': size.toInt()});
    state = await AsyncValue.guard(build);
  }

  Future<void> updateNotifications(bool value) async {
    await repo.updateProfile({'notifications_enabled': value});
    state = await AsyncValue.guard(build);
  }

  Future<void> signOut() async {
    await repo.signOut();
  }
}
