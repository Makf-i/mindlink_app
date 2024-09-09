import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlink/models/post_model.dart';
import 'package:mindlink/providers/image_provider.dart';
import 'package:share_plus/share_plus.dart';

class BoxWid extends ConsumerStatefulWidget {
  const BoxWid({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  ConsumerState<BoxWid> createState() => _BoxWidState();
}

class _BoxWidState extends ConsumerState<BoxWid> {
  void _sharePost(String postId, String postType) async {
    final String encodedUrl = Uri.encodeComponent(postId);
    final String postUrl =
        'https://mindlink-web.vercel.app/image?id=$encodedUrl&type=$postType';

    // Use the share_plus package to share the URL
    await Share.share('Check out this post: $postUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 0, left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.post.url,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  ref
                      .read(imageProvider.notifier)
                      .addToLikedImage(widget.post.id, widget.post.isFavorite);
                },
                icon: Icon(
                  widget.post.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  color: widget.post.isFavorite ? Colors.red : Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  _sharePost(widget.post.url, widget.post.type!);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
