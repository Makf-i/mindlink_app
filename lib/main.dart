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
          builder: (context, state) => TabsScreen(
            selectedTab: 'text', 
            strmLink: state.uri.queryParameters['id'], 
          ),
        ),
        GoRoute(
          path: 'video',
          builder: (context, state) => TabsScreen(
            selectedTab: 'video', 
            strmLink: state.uri.queryParameters['id'], 
          ),
        ),
        GoRoute(
          path: 'image',
          builder: (context, state) => TabsScreen(
            selectedTab: 'image', 
            strmLink: state.uri.queryParameters['id'], 
          ),
        ),
      ],
    ),
  ],
);























































// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) {
//         // Extract the query parameters if they exist
//         final selectedTab = state.uri.queryParameters['type']; // e.g., text, video, image
//         final id = state.uri.queryParameters['id']; // Media URL or ID
//         print("this is the selectedtab'''''''''''''''${selectedTab}");
//         print("this is the id '''''''''''''''''''''''''''''${id}");
//         // Pass the parameters to TabsScreen
//         return TabsScreen(
//           selectedTab: selectedTab ?? 'text', // Tab type: text, video, or image
//           strmLink: id, // Media URL
//         );
//       },
//     ),
//   ],
// );

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const TabsScreen(),
//       routes: [
//         GoRoute(
//           path: 'text',
//           builder: (context, state) => TextScreen(
//             strmLink: state.uri.queryParameters['id'],
//           ),
//         ),
//         GoRoute(
//           path: 'video',
//           builder: (context, state) => VideoScreen(
//             strmLink: state.uri.queryParameters['id'],
//           ),
//         ),
//         GoRoute(
//           path: 'image',
//           builder: (context, state) => ImageScreen(
//             strmLink: state.uri.queryParameters['id'],
//           ),
//         ),
//       ],
//     ),
//   ],
// );
