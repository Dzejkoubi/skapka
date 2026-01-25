// lib/services/supabase_service.dart
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_relation_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/group_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabaseClient = Supabase.instance.client;

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

  // Table accounts
  Future<AccountModel?> getAccountDetails(String accountId) async {
    final response = await _supabaseClient
        .from('accounts')
        .select()
        .eq('account_id', accountId)
        .maybeSingle();

    if (response == null) return null;
    return AccountModel.fromJson(response);
  }

  // Table groups
  Future<GroupModel> getAccountGroupDetail(String groupId) async {
    final response = await _supabaseClient
        .from('groups')
        .select()
        .eq('group_id', groupId)
        .single();

    return GroupModel.fromJson(response);
  }

  // Table accounts_dependents
  Future<List<AccountDependentRelationModel>> getAccountDependentRelations(
    String accountId,
  ) async {
    final response = await _supabaseClient
        .from('accounts_dependents')
        .select()
        .eq('account_id', accountId);
    return (response as List)
        .map<AccountDependentRelationModel>(
          (json) => AccountDependentRelationModel.fromJson(json),
        )
        .toList();
  }

  // Get all account_dependent relations for a group

  Future<List<AccountDependentRelationModel>>
  getAccountDependentRelationsByGroup({required String groupId}) async {
    final response = await _supabaseClient
        .from('accounts_dependents')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<AccountDependentRelationModel>(
          (json) => AccountDependentRelationModel.fromJson(json),
        )
        .toList();
  }

  // Table dependents
  Future<DependentModel?> getDependentDetail(String dependentId) async {
    final response = await _supabaseClient
        .from('dependents')
        .select()
        .eq('dependent_id', dependentId)
        .maybeSingle();
    if (response == null) return null;

    return DependentModel.fromJson(response);
  }

  // Table dependent_notes
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
    return response
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
  }

  // Get group events that have ended before given date
  Future<List<EventModel>> getOlderGroupEvents({
    required String groupId,
    required DateTime date,
  }) async {
    final response = await _supabaseClient
        .from('events')
        .select()
        .eq('group_id', groupId)
        .lt('end_date', date.toIso8601String())
        .order('end_date', ascending: false)
        .limit(20); // Load in chunks of 20

    return response
        .map<EventModel>((json) => EventModel.fromJson(json))
        .toList();
  }

  // Table dependents
  Future<List<DependentModel>> getGroupDependents({
    required String groupId,
    bool excludeArchived = true,
  }) async {
    var query = _supabaseClient
        .from('dependents')
        .select('''
      dependent_id,
      name,
      is_leader,
      surname,
      nickname,
      born,
      sex,
      parent1_email,
      parent1_phone,
      parent2_email,
      parent2_phone,
      contact_email,
      contact_phone,
      troop_id,
      patrol_id,
      is_archived,
      created_at,
      group_id,
      skautis_id
    ''')
        .eq('group_id', groupId);

    if (excludeArchived) {
      query = query.eq('is_archived', false);
    }

    final response = await query;
    return response
        .map<DependentModel>((json) => DependentModel.fromJson(json))
        .toList();
  }

  // Table accounts
  Future<List<AccountModel>> getGroupAccounts(
    String groupId, {
    bool onlyNotApproved = false,
    String? searchQuery,
  }) async {
    var query = _supabaseClient
        .from('accounts')
        .select()
        .eq('group_id', groupId);

    if (onlyNotApproved) {
      query = query.eq('is_approved', false);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.or(
        'name.ilike.%$searchQuery%,surname.ilike.%$searchQuery%',
      );
    }
    final response = await query;
    return (response as List)
        .map<AccountModel>((json) => AccountModel.fromJson(json))
        .toList();
  }

  Future<void> changeAccountApproval(String accountId, bool isApproved) async {
    await _supabaseClient
        .from('accounts')
        .update({'is_approved': isApproved})
        .eq('account_id', accountId);
  }

  // Table event_participants filtered by event_id
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

  // Table event_participants filtered by dependent_id
  Future<List<EventParticipantModel>> getDependentParticipation(
    String dependentId,
  ) async {
    final response = await _supabaseClient
        .from('event_participants')
        .select()
        .eq('dependent_id', dependentId);
    return (response as List)
        .map<EventParticipantModel>(
          (json) => EventParticipantModel.fromJson(json),
        )
        .toList();
  }

  // Table troops
  Future<List<TroopModel>> getGroupTroops(String groupId) async {
    final response = await _supabaseClient
        .from('troops')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<TroopModel>((json) => TroopModel.fromJson(json))
        .toList();
  }

  // Table patrols
  Future<List<PatrolModel>> getGroupPatrols(String groupId) async {
    final response = await _supabaseClient
        .from('patrols')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<PatrolModel>((json) => PatrolModel.fromJson(json))
        .toList();
  }

  // Table patrols_leaders
  Future<List<LeaderModel>> getGroupLeaders(String groupId) async {
    final response = await _supabaseClient
        .from('patrols_leaders')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<LeaderModel>((json) => LeaderModel.fromJson(json))
        .toList();
  }

  // Table events
  Future<EventModel> createEvent(
    EventModel event,
    AccountProvider accountProvider,
  ) async {
    // Validate we have a group ID
    if (accountProvider.groupId.isEmpty) {
      throw const FormatException("Cannot create event: Group ID is missing.");
    }

    final response = await _supabaseClient
        .from('events')
        .insert({
          'title': event.title,
          'instructions': event.instructions,
          'open_sign_up': event.openSignUp?.toIso8601String(),
          'close_sign_up': event.closeSignUp?.toIso8601String(),
          'start_date': event.startDate?.toIso8601String(),
          'end_date': event.endDate?.toIso8601String(),
          'meeting_place': event.meetingPlace,
          'photo_album_link': event.photoAlbumLink,
          'group_id': accountProvider.groupId,
          // Filter out any empty strings from target_patrols to prevent UUID errors
          'target_patrols': event.targetPatrolsIds
              ?.where((id) => id.isNotEmpty)
              .toList(),
          'last_edited_by': accountProvider.accountId,
          'is_draft': event.isDraft,
        })
        .select()
        .single(); // This returns the created event with the new UUID
    return EventModel.fromJson(response);
  }

  Future<void> editEventDetails(
    EventModel event,
    AccountProvider accountProvider,
  ) async {
    await _supabaseClient
        .from('events')
        .update({
          'title': event.title,
          'group_id': accountProvider.groupId,
          'instructions': event.instructions,
          'open_sign_up': event.openSignUp?.toIso8601String(),
          'close_sign_up': event.closeSignUp?.toIso8601String(),
          'start_date': event.startDate?.toIso8601String(),
          'end_date': event.endDate?.toIso8601String(),
          'meeting_place': event.meetingPlace,
          'photo_album_link': event.photoAlbumLink,
          'target_patrols': event.targetPatrolsIds,
          'last_edited_by': accountProvider.accountId,
          'is_draft': event.isDraft,
        })
        .eq('event_id', event.eventId);
  }

  Future<void> deleteEvent(String eventId) async {
    await _supabaseClient.from('events').delete().eq('event_id', eventId);
  }

  // New row into event_participants
  Future<void> addEventParticipant(EventParticipantModel participant) async {
    await _supabaseClient.from('event_participants').insert({
      'event_id': participant.eventId,
      'dependent_id': participant.dependentId,
      'status': participant.status.value,
      'group_id': participant.groupId,
    });
  }

  Future<void> removeEventParticipant({
    required String eventId,
    required String dependentId,
  }) async {
    await _supabaseClient
        .from('event_participants')
        .delete()
        .eq('event_id', eventId)
        .eq('dependent_id', dependentId);
  }

  Future<void> updateDependentEventParticipationStatus({
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

  // Table dependent_notes
  Future<void> updateDependentNotes({
    required String dependentId,
    required DependentNotesModel notes,
  }) async {
    await _supabaseClient.from('dependent_notes').upsert({
      'dependent_id': dependentId,
      'has_gluten_allergy': notes.hasGlutenAllergy,
      'has_lactose_intolerance': notes.hasLactoseIntolerance,
      'has_nut_allergy': notes.hasNutAllergy,
      'has_asthma': notes.hasAsthma,
      'is_claustrophobic': notes.isClaustrophobic,
      'has_epilepsy': notes.hasEpilepsy,
      'is_swimmer': notes.isSwimmer,
      'other_note': notes.otherNote,
    });
  }

  // Batch update account approval status
  Future<void> updateAccountApprovalStatus(
    String accountId,
    bool isApproved,
  ) async {
    await _supabaseClient
        .from('accounts')
        .update({'is_approved': isApproved})
        .eq('account_id', accountId);
  }

  Future<void> updateAccountRights(String accountId, int newRights) async {
    if (newRights == 3) {
      throw ArgumentError(
        'Rights value 3 is reserved for the admin and can be assigned only manually in the database.',
      );
    } else if (newRights < 0 || newRights > 2) {
      throw ArgumentError(
        'Invalid rights value: $newRights. Must be between 0 and 2.',
      );
    }
    await _supabaseClient
        .from('accounts')
        .update({'rights': newRights})
        .eq('account_id', accountId);
  }

  // Patrol leader management
  Future<void> addPatrolLeader({
    required String dependentId,
    required String patrolId,
    required String groupId,
  }) async {
    await _supabaseClient.from('patrols_leaders').insert({
      'dependent_id': dependentId,
      'patrol_id': patrolId,
      'group_id': groupId,
    });
  }

  Future<void> removePatrolLeader(String dependentId, String patrolId) async {
    await _supabaseClient
        .from('patrols_leaders')
        .delete()
        .eq('dependent_id', dependentId)
        .eq('patrol_id', patrolId);
  }

  Future<void> skautisSync({
    required String skautisToken,
    required String groupId,
  }) async {
    await _supabaseClient.functions.invoke(
      'skautis_sync?token=$skautisToken&group_id=$groupId',
    );
  }

  Future<void> addLeaderStatus(String dependentId) async {
    await _supabaseClient
        .from('dependents')
        .update({'is_leader': true})
        .eq('dependent_id', dependentId);
  }

  Future<void> removeLeaderStatus(String dependentId) async {
    await _supabaseClient
        .from('dependents')
        .update({'is_leader': false})
        .eq('dependent_id', dependentId);
  }

  Future<void> connectDependentToAccount({
    required String accountId,
    required String dependentId,
    required String groupId,
  }) async {
    await _supabaseClient.from('accounts_dependents').insert({
      'account_id': accountId,
      'dependent_id': dependentId,
      'group_id': groupId,
      'is_main_dependent': false,
    });
  }

  Future<void> disconnectDependentFromAccount({
    required String accountId,
    required String dependentId,
  }) async {
    await _supabaseClient
        .from('accounts_dependents')
        .delete()
        .eq('account_id', accountId)
        .eq('dependent_id', dependentId);
  }

  Future<void> setMainDependent({
    required String accountId,
    required String dependentId,
  }) async {
    // First, unset any existing main dependent for the account
    await _supabaseClient
        .from('accounts_dependents')
        .update({'is_main_dependent': false})
        .eq('account_id', accountId)
        .eq('is_main_dependent', true);

    // Then, set the new main dependent
    await _supabaseClient
        .from('accounts_dependents')
        .update({'is_main_dependent': true})
        .eq('account_id', accountId)
        .eq('dependent_id', dependentId);
  }
}
