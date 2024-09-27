import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlink/providers/image_provider.dart';
import 'package:mindlink/providers/text_provider.dart';
import 'package:mindlink/providers/video_provider.dart';
import 'package:mindlink/screens/liked_screen.dart';
import 'package:mindlink/screens/tab_screeens/image.dart';
import 'package:mindlink/screens/tab_screeens/text.dart';
import 'package:mindlink/screens/tab_screeens/video.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({
    super.key,
    this.selectedTab,
    this.strmLink,
  });

  final String? selectedTab;
  final String? strmLink;

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentPage = 0;

  @override
  void initState() {
    super.initState();
    ref.read(imageProvider.notifier).loadData();
    ref.read(videoProvider.notifier).loadData();
    ref.read(textProvider.notifier).loadData();

    if (widget.selectedTab == 'text') {
      _currentPage = 0; // Text tab index
    } else if (widget.selectedTab == 'video') {
      _currentPage = 1; // Video tab index
    } else if (widget.selectedTab == 'image') {
      _currentPage = 2; // Image tab index
    }
  }

  Widget get _title {
    switch (_currentPage) {
      case 1:
        return const Text("Video");
      case 2:
        return const Text("Image");
      default:
        return const Text("Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.help),
        ),
        drawer: Drawer(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  label: const Text("Liked posts"),
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LikedScreen()));
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text("SignOut"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPage,
          onDestinationSelected: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.text_snippet), label: "Text"),
            NavigationDestination(
                icon: Icon(Icons.video_collection), label: "Video"),
            NavigationDestination(icon: Icon(Icons.image), label: "Image"),
          ],
        ),
        body: [
          // PostScreens(index: _currentPage),
          TextScreen(strmLink: widget.strmLink),
          VideoScreen(strmLink: widget.strmLink),
          ImageScreen(strmLink: widget.strmLink),
        ][_currentPage]);
  }
}
