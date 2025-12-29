import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/router/router.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY']!,
  );
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => App(), // Wrap your app
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => DependentsProvider()),
        ChangeNotifierProvider(create: (context) => EventsProvider()),
      ],

      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: kDebugMode
                ? true
                : false, // Show debug banner only in debug mode
            title: 'Skapka',

            routerConfig: _appRouter.config(),

            // Add builder to sync theme with AppColorTheme
            builder: (context, child) {
              // Sync the theme whenever the app rebuilds
              AppColorTheme.updateTheme(Theme.of(context).brightness);
              return child ?? const SizedBox.shrink();
            },

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('cs'),
          );
        },
      ),
    );
  }
}
