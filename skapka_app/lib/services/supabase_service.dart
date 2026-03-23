// lib/services/supabase_service.dart
import 'package:flutter/foundation.dart';
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

  /// Adds a new account to the database upon registration.
  ///
  /// Required parameters:
  /// - [accountId] - the unique identifier for the account, typically the user's ID from Supabase Auth;
  /// - [name] - the first name of the account holder;
  /// - [surname] - the last name of the account holder;
  /// - [groupId] - the ID of the group to which the account belongs;
  /// - [isApproved] - indicates whether the account is approved by group administrators (default is false).
  Future<AccountModel> insertAccount({
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

  /// Checks if the currently logged-in user's account is approved by administrators.
  /// Returns true if approved, false otherwise or if no user is logged in.
  /// Unapproved users are shown a waiting screen and cannot access the app.
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

  /// Retrieves account details by account ID.
  /// Returns null if the account does not exist.
  ///
  /// [accountId] - The unique identifier of the account to fetch.
  Future<AccountModel?> getAccountDetails(String accountId) async {
    final response = await _supabaseClient
        .from('accounts')
        .select()
        .eq('account_id', accountId)
        .maybeSingle();

    if (response == null) return null;
    return AccountModel.fromJson(response);
  }

  /// Retrieves group details by group ID.
  ///
  /// [groupId] - The unique identifier of the group to fetch.
  Future<GroupModel> getAccountGroupDetail(String groupId) async {
    final response = await _supabaseClient
        .from('groups')
        .select()
        .eq('group_id', groupId)
        .single();

    return GroupModel.fromJson(response);
  }

  /// Retrieves all dependent relations linked to an account.
  ///
  /// [accountId] - The account to fetch dependents for.
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

  /// Retrieves all account-dependent relations for a specific group.
  ///
  /// [groupId] - The group to fetch relations for.
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

  /// Retrieves full details for a dependent from the 'dependents' table.
  /// Returns null if the dependent does not exist.
  ///
  /// [dependentId] - The dependent to fetch details for.
  Future<DependentModel?> getDependentDetail(String dependentId) async {
    final response = await _supabaseClient
        .from('dependents')
        .select()
        .eq('dependent_id', dependentId)
        .maybeSingle();
    if (response == null) return null;

    return DependentModel.fromJson(response);
  }

  /// Retrieves health and allergy notes for a dependent from the 'dependent_notes' table.
  /// Returns null if no notes exist for the dependent.
  ///
  /// [dependentId] - The dependent to fetch notes for.
  Future<DependentNotesModel?> getDependentNotes(String dependentId) async {
    final response = await _supabaseClient
        .from('dependent_notes')
        .select()
        .eq('dependent_id', dependentId)
        .maybeSingle();
    if (response == null) return null;
    return DependentNotesModel.fromJson(response);
  }

  /// Retrieves events for a group that end after a specified date from the 'events' table.
  /// Useful for loading events from the start of a school year.
  ///
  /// [groupId] - The group to fetch events for.
  /// [date] - Optional: Only fetch events ending on or after this date.
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

  /// Retrieves older events for a group that ended before a specified date from the 'events' table.
  /// Returns up to 20 events, ordered by end date (newest first).
  ///
  /// [groupId] - The group to fetch events for.
  /// [date] - Only fetch events ending before this date.
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

  /// Retrieves all dependents for a group from the 'dependents' table.
  ///
  /// [groupId] - The group to fetch dependents for.
  /// [excludeArchived] - If true (default), excludes archived dependents.
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

  /// Retrieves accounts for a group from the 'accounts' table.
  ///
  /// [groupId] - The group to fetch accounts for.
  /// [onlyNotApproved] - If true, returns only unapproved accounts.
  /// [searchQuery] - Optional: Filter by name or surname (case-insensitive).
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

  /// Updates the approval status of an account in the 'accounts' table.
  ///
  /// [accountId] - The account to update.
  /// [isApproved] - The new approval status.
  Future<void> changeAccountApproval(String accountId, bool isApproved) async {
    await _supabaseClient
        .from('accounts')
        .update({'is_approved': isApproved})
        .eq('account_id', accountId);
  }

  /// Retrieves all participants for a specific event from the 'event_participants' table.
  ///
  /// [eventId] - The event to fetch participants for.
  /// [groupId] - The group context (used for filtering).
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

  /// Retrieves all event participation records for a dependent from the 'event_participants' table.
  ///
  /// [dependentId] - The dependent to fetch participation records for.
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

  /// Retrieves all troops for a group from the 'troops' table.
  ///
  /// [groupId] - The group to fetch troops for.
  Future<List<TroopModel>> getGroupTroops(String groupId) async {
    final response = await _supabaseClient
        .from('troops')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<TroopModel>((json) => TroopModel.fromJson(json))
        .toList();
  }

  /// Retrieves all patrols for a group from the 'patrols' table.
  ///
  /// [groupId] - The group to fetch patrols for.
  Future<List<PatrolModel>> getGroupPatrols(String groupId) async {
    final response = await _supabaseClient
        .from('patrols')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<PatrolModel>((json) => PatrolModel.fromJson(json))
        .toList();
  }

  /// Retrieves all patrol leaders for a group from the 'patrols_leaders' table.
  ///
  /// [groupId] - The group to fetch leaders for.
  Future<List<LeaderModel>> getGroupLeaders(String groupId) async {
    final response = await _supabaseClient
        .from('patrols_leaders')
        .select()
        .eq('group_id', groupId);
    return (response as List)
        .map<LeaderModel>((json) => LeaderModel.fromJson(json))
        .toList();
  }

  /// Creates a new event in the 'events' table.
  /// Requires the account provider to have a valid group ID.
  ///
  /// [event] - The event model containing event details.
  /// [accountProvider] - The current account (used to get group ID and account ID).
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
          'leaving_place': event.leavingPlace,
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

  /// Updates an existing event in the 'events' table.
  ///
  /// [event] - The event model with updated details.
  /// [accountProvider] - The current account (used to get account ID for last_edited_by).
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
          'leaving_place': event.leavingPlace,
          'photo_album_link': event.photoAlbumLink,
          'target_patrols': event.targetPatrolsIds,
          'last_edited_by': accountProvider.accountId,
          'is_draft': event.isDraft,
        })
        .eq('event_id', event.eventId);
  }

  /// Deletes an event from the 'events' table.
  ///
  /// [eventId] - The event to delete.
  Future<void> deleteEvent(String eventId) async {
    await _supabaseClient.from('events').delete().eq('event_id', eventId);
  }

  /// Adds a new participant to an event in the 'event_participants' table.
  ///
  /// [participant] - The event participant record to insert.
  Future<void> addEventParticipant(EventParticipantModel participant) async {
    await _supabaseClient.from('event_participants').insert({
      'event_id': participant.eventId,
      'dependent_id': participant.dependentId,
      'status': participant.status.value,
      'group_id': participant.groupId,
    });
  }

  /// Removes a dependent's participation from an event in the 'event_participants' table.
  ///
  /// [eventId] - The event to remove participation from.
  /// [dependentId] - The dependent to remove.
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

  /// Updates a dependent's participation status for an event in the 'event_participants' table.
  ///
  /// [eventId] - The event to update participation for.
  /// [dependentId] - The dependent to update.
  /// [newStatus] - The new participation status.
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

  /// Updates health and allergy notes for a dependent in the 'dependent_notes' table.
  /// Creates the record if it doesn't exist.
  ///
  /// [dependentId] - The dependent to update notes for.
  /// [notes] - The notes model with updated health information.
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

  /// Updates the approval status of an account in the 'accounts' table.
  ///
  /// [accountId] - The account to update.
  /// [isApproved] - The new approval status.
  Future<void> updateAccountApprovalStatus(
    String accountId,
    bool isApproved,
  ) async {
    await _supabaseClient
        .from('accounts')
        .update({'is_approved': isApproved})
        .eq('account_id', accountId);
  }

  /// Updates account rights/permissions in the 'accounts' table.
  /// Rights 0-2 are user-assignable; rights 3 (admin) can only be set manually in the database.
  ///
  /// [accountId] - The account to update.
  /// [newRights] - The new rights level (0-2). Values outside this range throw ArgumentError.
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

  /// Adds a patrol leader assignment in the 'patrols_leaders' table.
  ///
  /// [dependentId] - The dependent to assign as leader.
  /// [patrolId] - The patrol to assign the leader to.
  /// [groupId] - The group context.
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

  /// Removes a patrol leader assignment from the 'patrols_leaders' table.
  ///
  /// [dependentId] - The dependent to remove as leader.
  /// [patrolId] - The patrol to remove the leader from.
  Future<void> removePatrolLeader(String dependentId, String patrolId) async {
    await _supabaseClient
        .from('patrols_leaders')
        .delete()
        .eq('dependent_id', dependentId)
        .eq('patrol_id', patrolId);
  }

  /// Syncs group data with Skautis API via a Supabase edge function.
  ///
  /// [skautisToken] - Authentication token for the Skautis API.
  /// [groupId] - The group to sync data for.
  Future<void> skautisSync({
    required String skautisToken,
    required String groupId,
  }) async {
    await _supabaseClient.functions.invoke(
      'skautis_sync?token=$skautisToken&group_id=$groupId',
    );
  }

  /// Marks a dependent as a leader in the 'dependents' table.
  ///
  /// [dependentId] - The dependent to mark as leader.
  Future<void> addLeaderStatus(String dependentId) async {
    await _supabaseClient
        .from('dependents')
        .update({'is_leader': true})
        .eq('dependent_id', dependentId);
  }

  /// Removes leader status from a dependent in the 'dependents' table.
  ///
  /// [dependentId] - The dependent to remove leader status from.
  Future<void> removeLeaderStatus(String dependentId) async {
    await _supabaseClient
        .from('dependents')
        .update({'is_leader': false})
        .eq('dependent_id', dependentId);
  }

  /// Links a dependent to an account in the 'accounts_dependents' table.
  ///
  /// [accountId] - The account to link to.
  /// [dependentId] - The dependent to link.
  /// [groupId] - The group context.
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

  /// Removes the link between a dependent and an account in the 'accounts_dependents' table.
  ///
  /// [accountId] - The account to unlink from.
  /// [dependentId] - The dependent to unlink.
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

  /// Sets a dependent as the main dependent for an account in the 'accounts_dependents' table.
  /// Automatically unsets any previously set main dependent.
  ///
  /// [accountId] - The account to set main dependent for.
  /// [dependentId] - The dependent to set as main.
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

  /// Removes main dependent status from a dependent in the 'accounts_dependents' table.
  ///
  /// [accountId] - The account to update.
  /// [dependentId] - The dependent to remove main status from.
  Future<void> unsetMainDependent({
    required String accountId,
    required String dependentId,
  }) async {
    await _supabaseClient
        .from('accounts_dependents')
        .update({'is_main_dependent': false})
        .eq('account_id', accountId)
        .eq('dependent_id', dependentId);
  }

  /// Saves the Firebase Cloud Messaging token for the current user in the 'accounts' table.
  /// Does nothing if no user is logged in.
  ///
  /// [token] - The FCM token to save.
  Future<void> saveFcmToken(String token) async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    final updated = await _supabaseClient
        .from('accounts')
        .update({'fcm_token': token})
        .eq('account_id', userId)
        .select('account_id');
    debugPrint('FCM: update affected ${updated.length} row(s)');
  }
}
