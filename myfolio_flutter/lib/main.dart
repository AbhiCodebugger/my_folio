import 'package:myfolio_client/myfolio_client.dart';
import 'package:flutter/material.dart';
import 'package:myfolio_flutter/providers/theme_provider.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/screens/home_screen.dart';
import 'package:myfolio_flutter/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
import 'dart:convert';
import 'package:flutter/services.dart';

late final Client client;

Future<String> getServerUrl() async {
  // 1. Check for dart define (set during build)
  const apiUrlDefine = String.fromEnvironment('API_URL');
  if (apiUrlDefine.isNotEmpty) {
    return apiUrlDefine;
  }

  // 2. Fallback to assets/config.json
  try {
    final configString = await rootBundle.loadString('assets/config.json');
    final config = jsonDecode(configString);
    return config['apiUrl'] ?? 'http://localhost:8080';
  } catch (e) {
    return 'http://localhost:8080';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await getServerUrl();

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
