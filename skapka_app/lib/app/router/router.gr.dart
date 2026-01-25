// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:collection/collection.dart' as _i34;
import 'package:flutter/foundation.dart' as _i35;
import 'package:flutter/material.dart' as _i28;
import 'package:skapka_app/models/dependents/account_dependent_model.dart'
    as _i37;
import 'package:skapka_app/models/dependents/dependent_model.dart' as _i29;
import 'package:skapka_app/models/event_model.dart' as _i36;
import 'package:skapka_app/models/event_participant_model.dart' as _i33;
import 'package:skapka_app/models/leader_model.dart' as _i32;
import 'package:skapka_app/models/patrol_model.dart' as _i30;
import 'package:skapka_app/models/troop_model.dart' as _i31;
import 'package:skapka_app/providers/units_provider.dart' as _i38;
import 'package:skapka_app/screens/account_not_approved_screen/account_not_approved_screen.dart'
    as _i1;
import 'package:skapka_app/screens/admin_panel_screen/admin_panel_screen.dart'
    as _i2;
import 'package:skapka_app/screens/approve_accounts_screen/approve_accounts_screen.dart'
    as _i3;
import 'package:skapka_app/screens/auth_gate/auth_gate.dart' as _i4;
import 'package:skapka_app/screens/calendar_screen/calendar_screen.dart' as _i6;
import 'package:skapka_app/screens/create_edit_event_screen.dart/create_edit_event_screen.dart'
    as _i9;
import 'package:skapka_app/screens/create_edit_event_screen.dart/screens/create_edit_event_instructions_screen.dart'
    as _i7;
import 'package:skapka_app/screens/create_edit_event_screen.dart/screens/create_edit_event_participants_screen.dart'
    as _i8;
import 'package:skapka_app/screens/dependents_screen/dependents_screen.dart'
    as _i10;
import 'package:skapka_app/screens/dependents_screen/screens/edit_dependent_details_screen.dart'
    as _i12;
import 'package:skapka_app/screens/edit_account_rights_screen.dart/edit_account_rights_screen.dart'
    as _i11;
import 'package:skapka_app/screens/edit_leaders_screen/edit_leaders_screen.dart'
    as _i13;
import 'package:skapka_app/screens/edit_leaders_screen/screens/set_patrol_leader_screen.dart'
    as _i23;
import 'package:skapka_app/screens/event_details_screen/event_details_screen.dart'
    as _i14;
import 'package:skapka_app/screens/information_screen/information_screen.dart'
    as _i15;
import 'package:skapka_app/screens/live_events_screen/live_events_screen.dart'
    as _i17;
import 'package:skapka_app/screens/login_screen/login_screen.dart' as _i18;
import 'package:skapka_app/screens/navbar_dashboard/navbar_dashboard.dart'
    as _i19;
import 'package:skapka_app/screens/register_screen/register_screen_first.dart'
    as _i20;
import 'package:skapka_app/screens/register_screen/register_screen_second.dart'
    as _i21;
import 'package:skapka_app/screens/send_notification_screen/send_notification_screen.dart'
    as _i22;
import 'package:skapka_app/screens/settings_screen/settings_screen.dart'
    as _i24;
import 'package:skapka_app/screens/theme_showcase_screens/button_theme_showcase.dart'
    as _i5;
import 'package:skapka_app/screens/theme_showcase_screens/large_dialog_showcase.dart'
    as _i16;
import 'package:skapka_app/screens/theme_showcase_screens/squircle_showcase.dart'
    as _i25;
import 'package:skapka_app/screens/welcome_screen/welcome_screen.dart' as _i26;

/// generated route for
/// [_i1.AccountNotApprovedScreen]
class AccountNotApprovedRoute extends _i27.PageRouteInfo<void> {
  const AccountNotApprovedRoute({List<_i27.PageRouteInfo>? children})
    : super(AccountNotApprovedRoute.name, initialChildren: children);

  static const String name = 'AccountNotApprovedRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountNotApprovedScreen();
    },
  );
}

/// generated route for
/// [_i2.AdminPanelScreen]
class AdminPanelRoute extends _i27.PageRouteInfo<void> {
  const AdminPanelRoute({List<_i27.PageRouteInfo>? children})
    : super(AdminPanelRoute.name, initialChildren: children);

  static const String name = 'AdminPanelRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i2.AdminPanelScreen();
    },
  );
}

/// generated route for
/// [_i3.ApproveAccountsScreen]
class ApproveAccountsRoute extends _i27.PageRouteInfo<void> {
  const ApproveAccountsRoute({List<_i27.PageRouteInfo>? children})
    : super(ApproveAccountsRoute.name, initialChildren: children);

  static const String name = 'ApproveAccountsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i3.ApproveAccountsScreen();
    },
  );
}

/// generated route for
/// [_i4.AuthGate]
class AuthGate extends _i27.PageRouteInfo<void> {
  const AuthGate({List<_i27.PageRouteInfo>? children})
    : super(AuthGate.name, initialChildren: children);

  static const String name = 'AuthGate';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i4.AuthGate();
    },
  );
}

/// generated route for
/// [_i5.ButtonThemeShowcaseScreen]
class ButtonThemeShowcaseRoute extends _i27.PageRouteInfo<void> {
  const ButtonThemeShowcaseRoute({List<_i27.PageRouteInfo>? children})
    : super(ButtonThemeShowcaseRoute.name, initialChildren: children);

  static const String name = 'ButtonThemeShowcaseRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i5.ButtonThemeShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i6.CalendarScreen]
class CalendarRoute extends _i27.PageRouteInfo<void> {
  const CalendarRoute({List<_i27.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i6.CalendarScreen();
    },
  );
}

/// generated route for
/// [_i7.CreateEditEventInstructionsScreen]
class CreateEditEventInstructionsRoute
    extends _i27.PageRouteInfo<CreateEditEventInstructionsRouteArgs> {
  CreateEditEventInstructionsRoute({
    _i28.Key? key,
    String? initialInstructions,
    required dynamic Function(String) onSave,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         CreateEditEventInstructionsRoute.name,
         args: CreateEditEventInstructionsRouteArgs(
           key: key,
           initialInstructions: initialInstructions,
           onSave: onSave,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditEventInstructionsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditEventInstructionsRouteArgs>();
      return _i7.CreateEditEventInstructionsScreen(
        key: args.key,
        initialInstructions: args.initialInstructions,
        onSave: args.onSave,
      );
    },
  );
}

class CreateEditEventInstructionsRouteArgs {
  const CreateEditEventInstructionsRouteArgs({
    this.key,
    this.initialInstructions,
    required this.onSave,
  });

  final _i28.Key? key;

  final String? initialInstructions;

  final dynamic Function(String) onSave;

  @override
  String toString() {
    return 'CreateEditEventInstructionsRouteArgs{key: $key, initialInstructions: $initialInstructions, onSave: $onSave}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateEditEventInstructionsRouteArgs) return false;
    return key == other.key && initialInstructions == other.initialInstructions;
  }

  @override
  int get hashCode => key.hashCode ^ initialInstructions.hashCode;
}

/// generated route for
/// [_i8.CreateEditEventParticipantsScreen]
class CreateEditEventParticipantsRoute
    extends _i27.PageRouteInfo<CreateEditEventParticipantsRouteArgs> {
  CreateEditEventParticipantsRoute({
    _i28.Key? key,
    required List<_i29.DependentModel> groupDependents,
    required List<_i30.PatrolModel> groupPatrols,
    required List<_i31.TroopModel> groupTroops,
    required List<_i32.LeaderModel> groupLeaders,
    required List<_i33.EventParticipantModel> initialParticipants,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         CreateEditEventParticipantsRoute.name,
         args: CreateEditEventParticipantsRouteArgs(
           key: key,
           groupDependents: groupDependents,
           groupPatrols: groupPatrols,
           groupTroops: groupTroops,
           groupLeaders: groupLeaders,
           initialParticipants: initialParticipants,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditEventParticipantsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditEventParticipantsRouteArgs>();
      return _i8.CreateEditEventParticipantsScreen(
        key: args.key,
        groupDependents: args.groupDependents,
        groupPatrols: args.groupPatrols,
        groupTroops: args.groupTroops,
        groupLeaders: args.groupLeaders,
        initialParticipants: args.initialParticipants,
      );
    },
  );
}

class CreateEditEventParticipantsRouteArgs {
  const CreateEditEventParticipantsRouteArgs({
    this.key,
    required this.groupDependents,
    required this.groupPatrols,
    required this.groupTroops,
    required this.groupLeaders,
    required this.initialParticipants,
  });

  final _i28.Key? key;

  final List<_i29.DependentModel> groupDependents;

  final List<_i30.PatrolModel> groupPatrols;

  final List<_i31.TroopModel> groupTroops;

  final List<_i32.LeaderModel> groupLeaders;

  final List<_i33.EventParticipantModel> initialParticipants;

  @override
  String toString() {
    return 'CreateEditEventParticipantsRouteArgs{key: $key, groupDependents: $groupDependents, groupPatrols: $groupPatrols, groupTroops: $groupTroops, groupLeaders: $groupLeaders, initialParticipants: $initialParticipants}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateEditEventParticipantsRouteArgs) return false;
    return key == other.key &&
        const _i34.ListEquality<_i29.DependentModel>().equals(
          groupDependents,
          other.groupDependents,
        ) &&
        const _i34.ListEquality<_i30.PatrolModel>().equals(
          groupPatrols,
          other.groupPatrols,
        ) &&
        const _i34.ListEquality<_i31.TroopModel>().equals(
          groupTroops,
          other.groupTroops,
        ) &&
        const _i34.ListEquality<_i32.LeaderModel>().equals(
          groupLeaders,
          other.groupLeaders,
        ) &&
        const _i34.ListEquality<_i33.EventParticipantModel>().equals(
          initialParticipants,
          other.initialParticipants,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i34.ListEquality<_i29.DependentModel>().hash(groupDependents) ^
      const _i34.ListEquality<_i30.PatrolModel>().hash(groupPatrols) ^
      const _i34.ListEquality<_i31.TroopModel>().hash(groupTroops) ^
      const _i34.ListEquality<_i32.LeaderModel>().hash(groupLeaders) ^
      const _i34.ListEquality<_i33.EventParticipantModel>().hash(
        initialParticipants,
      );
}

/// generated route for
/// [_i9.CreateEditEventScreen]
class CreateEditEventRoute
    extends _i27.PageRouteInfo<CreateEditEventRouteArgs> {
  CreateEditEventRoute({
    _i35.Key? key,
    _i36.EventModel? event,
    _i36.EventTimeType? eventTimeType,
    List<_i33.EventParticipantModel>? eventParticipants,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         CreateEditEventRoute.name,
         args: CreateEditEventRouteArgs(
           key: key,
           event: event,
           eventTimeType: eventTimeType,
           eventParticipants: eventParticipants,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditEventRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditEventRouteArgs>(
        orElse: () => const CreateEditEventRouteArgs(),
      );
      return _i9.CreateEditEventScreen(
        key: args.key,
        event: args.event,
        eventTimeType: args.eventTimeType,
        eventParticipants: args.eventParticipants,
      );
    },
  );
}

class CreateEditEventRouteArgs {
  const CreateEditEventRouteArgs({
    this.key,
    this.event,
    this.eventTimeType,
    this.eventParticipants,
  });

  final _i35.Key? key;

  final _i36.EventModel? event;

  final _i36.EventTimeType? eventTimeType;

  final List<_i33.EventParticipantModel>? eventParticipants;

  @override
  String toString() {
    return 'CreateEditEventRouteArgs{key: $key, event: $event, eventTimeType: $eventTimeType, eventParticipants: $eventParticipants}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateEditEventRouteArgs) return false;
    return key == other.key &&
        event == other.event &&
        eventTimeType == other.eventTimeType &&
        const _i34.ListEquality<_i33.EventParticipantModel>().equals(
          eventParticipants,
          other.eventParticipants,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      event.hashCode ^
      eventTimeType.hashCode ^
      const _i34.ListEquality<_i33.EventParticipantModel>().hash(
        eventParticipants,
      );
}

/// generated route for
/// [_i10.DependentsScreen]
class DependentsRoute extends _i27.PageRouteInfo<void> {
  const DependentsRoute({List<_i27.PageRouteInfo>? children})
    : super(DependentsRoute.name, initialChildren: children);

  static const String name = 'DependentsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i10.DependentsScreen();
    },
  );
}

/// generated route for
/// [_i11.EditAccountRightsScreen]
class EditAccountRightsRoute extends _i27.PageRouteInfo<void> {
  const EditAccountRightsRoute({List<_i27.PageRouteInfo>? children})
    : super(EditAccountRightsRoute.name, initialChildren: children);

  static const String name = 'EditAccountRightsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i11.EditAccountRightsScreen();
    },
  );
}

/// generated route for
/// [_i12.EditDependentDetailsScreen]
class EditDependentDetailsRoute
    extends _i27.PageRouteInfo<EditDependentDetailsRouteArgs> {
  EditDependentDetailsRoute({
    _i28.Key? key,
    required _i37.AccountDependentModel dependent,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         EditDependentDetailsRoute.name,
         args: EditDependentDetailsRouteArgs(key: key, dependent: dependent),
         initialChildren: children,
       );

  static const String name = 'EditDependentDetailsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditDependentDetailsRouteArgs>();
      return _i12.EditDependentDetailsScreen(
        key: args.key,
        dependent: args.dependent,
      );
    },
  );
}

class EditDependentDetailsRouteArgs {
  const EditDependentDetailsRouteArgs({this.key, required this.dependent});

  final _i28.Key? key;

  final _i37.AccountDependentModel dependent;

  @override
  String toString() {
    return 'EditDependentDetailsRouteArgs{key: $key, dependent: $dependent}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditDependentDetailsRouteArgs) return false;
    return key == other.key && dependent == other.dependent;
  }

  @override
  int get hashCode => key.hashCode ^ dependent.hashCode;
}

/// generated route for
/// [_i13.EditLeadersScreen]
class EditLeadersRoute extends _i27.PageRouteInfo<void> {
  const EditLeadersRoute({List<_i27.PageRouteInfo>? children})
    : super(EditLeadersRoute.name, initialChildren: children);

  static const String name = 'EditLeadersRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i13.EditLeadersScreen();
    },
  );
}

/// generated route for
/// [_i14.EventDetailsScreen]
class EventDetailsRoute extends _i27.PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({
    _i28.Key? key,
    required _i36.EventModel event,
    required _i36.EventTimeType eventTimeType,
    required _i38.UnitsProvider unitsProvider,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         EventDetailsRoute.name,
         args: EventDetailsRouteArgs(
           key: key,
           event: event,
           eventTimeType: eventTimeType,
           unitsProvider: unitsProvider,
         ),
         initialChildren: children,
       );

  static const String name = 'EventDetailsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventDetailsRouteArgs>();
      return _i14.EventDetailsScreen(
        key: args.key,
        event: args.event,
        eventTimeType: args.eventTimeType,
        unitsProvider: args.unitsProvider,
      );
    },
  );
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({
    this.key,
    required this.event,
    required this.eventTimeType,
    required this.unitsProvider,
  });

  final _i28.Key? key;

  final _i36.EventModel event;

  final _i36.EventTimeType eventTimeType;

  final _i38.UnitsProvider unitsProvider;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{key: $key, event: $event, eventTimeType: $eventTimeType, unitsProvider: $unitsProvider}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventDetailsRouteArgs) return false;
    return key == other.key &&
        event == other.event &&
        eventTimeType == other.eventTimeType &&
        unitsProvider == other.unitsProvider;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      event.hashCode ^
      eventTimeType.hashCode ^
      unitsProvider.hashCode;
}

/// generated route for
/// [_i15.InformationScreen]
class InformationRoute extends _i27.PageRouteInfo<void> {
  const InformationRoute({List<_i27.PageRouteInfo>? children})
    : super(InformationRoute.name, initialChildren: children);

  static const String name = 'InformationRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i15.InformationScreen();
    },
  );
}

/// generated route for
/// [_i16.LargeDialogShowcaseScreen]
class LargeDialogShowcaseRoute extends _i27.PageRouteInfo<void> {
  const LargeDialogShowcaseRoute({List<_i27.PageRouteInfo>? children})
    : super(LargeDialogShowcaseRoute.name, initialChildren: children);

  static const String name = 'LargeDialogShowcaseRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i16.LargeDialogShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i17.LiveEventsScreen]
class LiveEventsRoute extends _i27.PageRouteInfo<void> {
  const LiveEventsRoute({List<_i27.PageRouteInfo>? children})
    : super(LiveEventsRoute.name, initialChildren: children);

  static const String name = 'LiveEventsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i17.LiveEventsScreen();
    },
  );
}

/// generated route for
/// [_i18.LoginScreen]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute({List<_i27.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i18.LoginScreen();
    },
  );
}

/// generated route for
/// [_i19.NavbarDashboard]
class NavbarDashboard extends _i27.PageRouteInfo<void> {
  const NavbarDashboard({List<_i27.PageRouteInfo>? children})
    : super(NavbarDashboard.name, initialChildren: children);

  static const String name = 'NavbarDashboard';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i19.NavbarDashboard();
    },
  );
}

/// generated route for
/// [_i20.RegisterScreenFirst]
class RegisterRouteFirst extends _i27.PageRouteInfo<void> {
  const RegisterRouteFirst({List<_i27.PageRouteInfo>? children})
    : super(RegisterRouteFirst.name, initialChildren: children);

  static const String name = 'RegisterRouteFirst';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i20.RegisterScreenFirst();
    },
  );
}

/// generated route for
/// [_i21.RegisterScreenSecond]
class RegisterRouteSecond extends _i27.PageRouteInfo<RegisterRouteSecondArgs> {
  RegisterRouteSecond({
    _i28.Key? key,
    required String email,
    required String name,
    required String surname,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         RegisterRouteSecond.name,
         args: RegisterRouteSecondArgs(
           key: key,
           email: email,
           name: name,
           surname: surname,
         ),
         initialChildren: children,
       );

  static const String name = 'RegisterRouteSecond';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteSecondArgs>();
      return _i21.RegisterScreenSecond(
        key: args.key,
        email: args.email,
        name: args.name,
        surname: args.surname,
      );
    },
  );
}

class RegisterRouteSecondArgs {
  const RegisterRouteSecondArgs({
    this.key,
    required this.email,
    required this.name,
    required this.surname,
  });

  final _i28.Key? key;

  final String email;

  final String name;

  final String surname;

  @override
  String toString() {
    return 'RegisterRouteSecondArgs{key: $key, email: $email, name: $name, surname: $surname}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteSecondArgs) return false;
    return key == other.key &&
        email == other.email &&
        name == other.name &&
        surname == other.surname;
  }

  @override
  int get hashCode =>
      key.hashCode ^ email.hashCode ^ name.hashCode ^ surname.hashCode;
}

/// generated route for
/// [_i22.SendNotificationScreen]
class SendNotificationRoute extends _i27.PageRouteInfo<void> {
  const SendNotificationRoute({List<_i27.PageRouteInfo>? children})
    : super(SendNotificationRoute.name, initialChildren: children);

  static const String name = 'SendNotificationRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i22.SendNotificationScreen();
    },
  );
}

/// generated route for
/// [_i23.SetPatrolLeaderScreen]
class SetPatrolLeaderRoute
    extends _i27.PageRouteInfo<SetPatrolLeaderRouteArgs> {
  SetPatrolLeaderRoute({
    _i28.Key? key,
    required _i29.DependentModel dependent,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         SetPatrolLeaderRoute.name,
         args: SetPatrolLeaderRouteArgs(key: key, dependent: dependent),
         initialChildren: children,
       );

  static const String name = 'SetPatrolLeaderRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SetPatrolLeaderRouteArgs>();
      return _i23.SetPatrolLeaderScreen(
        key: args.key,
        dependent: args.dependent,
      );
    },
  );
}

class SetPatrolLeaderRouteArgs {
  const SetPatrolLeaderRouteArgs({this.key, required this.dependent});

  final _i28.Key? key;

  final _i29.DependentModel dependent;

  @override
  String toString() {
    return 'SetPatrolLeaderRouteArgs{key: $key, dependent: $dependent}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SetPatrolLeaderRouteArgs) return false;
    return key == other.key && dependent == other.dependent;
  }

  @override
  int get hashCode => key.hashCode ^ dependent.hashCode;
}

/// generated route for
/// [_i24.SettingsScreen]
class SettingsRoute extends _i27.PageRouteInfo<void> {
  const SettingsRoute({List<_i27.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i24.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i25.SquircleShowcaseScreen]
class SquircleShowcaseRoute extends _i27.PageRouteInfo<void> {
  const SquircleShowcaseRoute({List<_i27.PageRouteInfo>? children})
    : super(SquircleShowcaseRoute.name, initialChildren: children);

  static const String name = 'SquircleShowcaseRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i25.SquircleShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i26.WelcomeScreen]
class WelcomeRoute extends _i27.PageRouteInfo<void> {
  const WelcomeRoute({List<_i27.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i26.WelcomeScreen();
    },
  );
}
