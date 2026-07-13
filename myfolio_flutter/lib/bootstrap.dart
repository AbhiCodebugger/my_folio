import 'package:flutter/material.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/config/environment.dart';
import 'package:myfolio_flutter/providers/theme_provider.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/screens/home_screen.dart';
import 'package:myfolio_flutter/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Global client object used to talk to the server from anywhere in the app.
/// The client is generated from the server code. In a larger app you may want
/// to use dependency injection instead of a global.
late final Client client;

/// Shared startup logic for every flavor. The flavor-specific entry points
/// (`lib/main_dev.dart`, `lib/main.dart`) call this after selecting the
/// [Environment].
Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.initialize(flavor);

  final serverUrl = await Environment.current.resolveApiUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MyFolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
