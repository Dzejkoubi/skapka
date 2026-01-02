// lib/services/supabase_service.dart
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/group_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
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

  Future<GroupModel> getAccountGroupDetail(String groupId) async {
    final response = await _supabaseClient
        .from('groups')
        .select()
        .eq('group_id', groupId)
        .single();

    return GroupModel.fromJson(response);
  }

  Future<List<AccountDependentModel>> getAccountDependents(
    String accountId,
  ) async {
    final response = await _supabaseClient
        .from('accounts_dependents')
        .select()
        .eq('account_id', accountId);
    return (response as List)
        .map<AccountDependentModel>(
          (json) =>
              AccountDependentModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<DependentModel?> getDependentDetail(String dependentId) async {
    final response = await _supabaseClient
        .from('dependents')
        .select()
        .eq('dependent_id', dependentId)
        .maybeSingle();
    if (response == null) return null;
    return DependentModel.fromJson(response);
  }

  Future<DependentNotesModel?> getDependentNotes(String dependentId) async {
    final response = await _supabaseClient
        .from('dependent_notes')
        .select()
        .eq('dependent_id', dependentId)
        .maybeSingle();
    if (response == null) return null;
    return DependentNotesModel.fromJson(response);
  }

  // Get group events that have ended after given date(for example after start of this school year)
  Future<List<EventModel>> getGroupEvents({
    required String groupId,
    DateTime? date,
  }) async {
    var qery = _supabaseClient.from('events').select().eq('group_id', groupId);

    if (date != null) {
      qery = qery.gte('end_date', date.toIso8601String());
    }

    final response = await qery;

    print(response.length);
    return response
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
  }

  // Get all active dependents in given group
  Future<List<DependentModel>> getGroupDependents(
    String groupId, {
    bool includeArchived = true,
  }) async {
    var query = _supabaseClient
        .from('dependents')
        .select('''
      dependent_id,
      name,
      surname,
      nickname,
      born,
      sex,
      parent1_email,
      parent1_phone,
      parent2_email,
      parent2_phone,
      troop_id,
      patrol_id,
      archived,
      created_at,
      group_id
    ''')
        .eq('group_id', groupId);

    if (!includeArchived) {
      query = query.eq('archived', false);
    }

    final response = await query;
    return response.map((json) => DependentModel.fromJson(json)).toList();
  }

  // Get users that are invited to given event with their statuses
  Future<List<EventParticipantModel>> getEventParticipants(
    String eventId,
    String groupId,
  ) async {
    final response = await _supabaseClient
        .from('event_participants')
        .select()
        .eq('event_id', eventId)
        .eq('group_id', groupId);
    return (response as List)
        .map<EventParticipantModel>(
          (json) => EventParticipantModel.fromJson(json),
        )
        .toList();
  }

  // Get group troops
  Future<List<TroopModel>> getGroupTroops(String groupId) async {
    final response = await _supabaseClient
        .from('troops')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<TroopModel>((json) => TroopModel.fromJson(json))
        .toList();
  }

  // Get group patrols
  Future<List<PatrolModel>> getGroupPatrols(String groupId) async {
    final response = await _supabaseClient
        .from('patrols')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<PatrolModel>((json) => PatrolModel.fromJson(json))
        .toList();
  }

  // Get groups leaders
  Future<List<LeaderModel>> getGroupLeaders(String groupId) async {
    final response = await _supabaseClient
        .from('leaders')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<LeaderModel>((json) => LeaderModel.fromJson(json))
        .toList();
  }

  // Update dependent event participation status
  Future<void> updateEventParticipationStatus({
    required String eventId,
    required String dependentId,
    required String newStatus,
  }) async {
    await _supabaseClient
        .from('event_participants')
        .update({'status': newStatus})
        .eq('event_id', eventId)
        .eq('dependent_id', dependentId);
  }
}
