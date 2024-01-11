import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseHelper {
  static final SupabaseHelper _instance = SupabaseHelper._internal();

  factory SupabaseHelper() => _instance;

  SupabaseHelper._internal();

  static final String supabaseUrl = "${dotenv.env['SUPABASE_URL']}";
  static final String supabaseKey = "${dotenv.env['SUPABASE_KEY']}";

  final SupabaseClient _client = SupabaseClient(supabaseUrl, supabaseKey);

  SupabaseClient get client => _client;

  Future<List<Map<String, dynamic>>> fetchFromTable(
    String tableName,
  ) async {
    final response = await _client.from(tableName).select();
    return response;
  }

  Stream<List<Map<String, dynamic>>> fetchAndStreamTable(
    String tableName,
  ) {
    final response = _client.from(tableName).stream(primaryKey: ['id']);
    return response;
  }

  Future<void> addToTable(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.from(tableName).upsert([data]);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> insertToTable(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.from(tableName).insert(data);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> removeFromTable(
    String tableName,
    String id,
  ) async {
    final response = await _client.from(tableName).delete().eq('id', id);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> updateTable(
    String tableName,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.from(tableName).update(data).eq('id', id);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteFromTable(
    String tableName,
    String id,
  ) async {
    final response = await _client.from(tableName).delete().eq('id', id);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
