import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>> fetchProfile() async {
    final user = _client.auth.currentUser!;
    final res = await _client
        .from('profiles')
        .select()
        .eq('user_id', user.id)
        .single();
    return res;
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final user = _client.auth.currentUser!;
    await _client.from('profiles').update(data).eq('user_id', user.id);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
