import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlink/providers/image_provider.dart';
import 'package:mindlink/providers/text_provider.dart';
import 'package:mindlink/providers/video_provider.dart';
import 'package:mindlink/widgets/image_tile.dart';
import 'package:mindlink/widgets/text_tile.dart';
import 'package:mindlink/widgets/video_tile.dart';

class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedImages = ref
        .watch(imageProvider)
        .where((element) => element.isFavorite == true)
        .toList();
    final likedVideos = ref
        .watch(videoProvider)
        .where((element) => element.isFavorite == true)
        .toList();
    final likedText = ref
        .watch(textProvider)
        .where((element) => element.isFavorite == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: likedImages.isNotEmpty ||
                likedVideos.isNotEmpty ||
                likedText.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    if (likedImages.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: likedImages.length,
                        itemBuilder: (context, index) => BoxWid(
                          post: likedImages[index],
                        ),
                      ),
                    if (likedVideos.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: likedVideos.length,
                        itemBuilder: (context, index) => VideoTile(
                          post: likedVideos[index],
                        ),
                      ),
                    if (likedText.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: likedText.length,
                        itemBuilder: (context, index) => TextTile(
                          post: likedText[index],
                        ),
                      ),
                  ],
                ),
              )
            : const Center(child: Text("No liked post yet")),
      ),
    );
  }
}
