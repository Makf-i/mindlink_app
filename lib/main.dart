import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindlink/firebase_options.dart';
import 'package:mindlink/screens/auth_screens.dart/auth.dart';
import 'package:mindlink/screens/tab_screeens/image.dart';
import 'package:mindlink/screens/tab_screeens/tabs.dart';
import 'package:mindlink/screens/tab_screeens/text.dart';
import 'package:mindlink/screens/tab_screeens/video.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp.router(
            routerConfig: router,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const MaterialApp(
            home: AuthScreen(),
          );
        }
      },
    );
  }
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TabsScreen(),
      routes: [
        GoRoute(
          path: 'text',
          builder: (context, state) => TextScreen(
            strmLink: state.uri.queryParameters['id'],
          ),
        ),
        GoRoute(
          path: 'video',
          builder: (context, state) => VideoScreen(
            strmLink: state.uri.queryParameters['id'],
          ),
        ),
        GoRoute(
          path: 'image',
          builder: (context, state) => ImageScreen(
            strmLink: state.uri.queryParameters['id'],
          ),
        ),
      ],
    ),
  ],
);
