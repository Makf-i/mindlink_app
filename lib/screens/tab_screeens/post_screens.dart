// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mindlink/providers/image_provider.dart';
// import 'package:mindlink/providers/video_provider.dart';
// import 'package:mindlink/widgets/box.dart';

// class PostScreens extends ConsumerStatefulWidget {
//   const PostScreens({
//     super.key,
//     this.index = 0,
//     this.strmLink,
//   });

//   final int? index;
//   final String? strmLink;

//   @override
//   ConsumerState<PostScreens> createState() => _PostScreensState();
// }

// class _PostScreensState extends ConsumerState<PostScreens> {
//   @override
//   Widget build(BuildContext context) {
//     //final postId = ModalRoute.of(context)!.settings.arguments as String?;
//     var avlbPosts = [];
//     final avlbImagePosts = ref.watch(imageProvider);
//     if (widget.index == 0) {
//       final avlbPosts = [];
//     }

//     if (widget.index == 1) {
//       final avlbVideoPosts = ref.watch(videoProvider);
//       avlbPosts = avlbVideoPosts;
//     }
//     if (widget.index == 2) {
//       final avlbImagePosts = ref.watch(imageProvider);
//       avlbPosts = avlbImagePosts;
//     }

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: ListView.builder(
//             itemCount: avlbPosts.length,
//             itemBuilder: (context, index) {
//               return BoxWid(
//                 post: avlbPosts[index],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
