// lib/services/supabase_service.dart
import 'package:skapka_app/models/account_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabaseClient = Supabase.instance.client;

  // Edit account details
  Future<AccountModel> editAccountDetails({
    required String accountId,
    required String name,
    required String surname,
    required String groupId,
    bool isApproved = false,
  }) async {
    final response = await _supabaseClient
        .from('accounts')
        .insert({
          'account_id': accountId,
          'name': name,
          'surname': surname,
          'group_id': groupId,
          'is_approved': isApproved,
        })
        .select()
        .single();
    return AccountModel.fromJson(response);
  }

  // Check if logged account is approved
  Future<bool> isLoggedAccountApproved() async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await _supabaseClient.functions.invoke(
        'is_account_approved',
        body: {'account_id': user.id},
      );
      return response.data?['is_approved'] ?? false;
    }
    return false;
  }

  // Get account details
  Future<AccountModel?> getAccountDetails(String accountId) async {
    final response = await _supabaseClient
        .from('accounts')
        .select()
        .eq('account_id', accountId)
        .maybeSingle();

    if (response == null) return null;
    return AccountModel.fromJson(response);
  }

  Future<PostgrestMap> getAccountGroupDetail(String groupId) async {
    final response = await _supabaseClient
        .from('groups')
        .select()
        .eq('group_id', groupId)
        .single();
    return response;
  }

  Future<PostgrestList> getAccountDependents(String accountId) async {
    final response = await _supabaseClient
        .from('accounts_dependents')
        .select()
        .eq('account_id', accountId);
    return response;
  }

  Future<PostgrestMap> getDependentDetail(String dependentId) async {
    final response = await _supabaseClient
        .from('dependents')
        .select()
        .eq('dependent_id', dependentId)
        .single();
    return response;
  }

  Future<PostgrestList> getEventsForDependent(String dependentId) async {
    final response = await _supabaseClient
        .from('event_participants')
        .select()
        .eq('dependent_id', dependentId);
    return response;
  }

  Future<PostgrestMap> getEventDetail(String eventId) async {
    final response = await _supabaseClient
        .from('events')
        .select()
        .eq('event_id', eventId)
        .single();
    return response;
  }

  Future<PostgrestList> getEventParticipants(String eventId) async {
    final response = await _supabaseClient
        .from('event_participants')
        .select()
        .eq('event_id', eventId);
    return response;
  }

  // Update dependent event participation status
  Future<void> updateEventParticipationStatus({
    required String eventId,
    required String dependentId,
    required String status,
  }) async {
    await _supabaseClient
        .from('event_participants')
        .update({'status': status})
        .eq('event_id', eventId)
        .eq('dependent_id', dependentId);
  }
}
