import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlink/providers/video_provider.dart';
import 'package:mindlink/widgets/video_tile.dart';

class VideoScreen extends ConsumerStatefulWidget {
  const VideoScreen({
    super.key,
    this.strmLink,
  });

  final String? strmLink;

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  String linkPost = '';

  @override
  void initState() {
    print("initalized first");
    super.initState();
    _gotLinkedPost();
  }

  void _gotLinkedPost() {
    print("gotlinkedpost function");
    if (widget.strmLink != null) {
      // final Uri deepLink = Uri.parse(widget.strmLink!);
      linkPost = widget.strmLink!; //deepLink.queryParameters['postId']!;
      print("got link post");
      print(linkPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avlbVideoPosts = ref.watch(videoProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: avlbVideoPosts.length,
            itemBuilder: (context, index) {
              final post = avlbVideoPosts[index];
              final isLinked = post.url == linkPost;

              print("hello");
              return Container(
                decoration: BoxDecoration(
                  border: isLinked
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                child: VideoTile(
                  post: avlbVideoPosts[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
