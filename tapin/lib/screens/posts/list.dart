// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../model/post.dart';
//
// class ListPosts extends StatefulWidget {
//   //PostModel post;
//   ListPosts({Key? key}) : super(key: key);
//
//
//   @override
//   _ListPostsState createState() => _ListPostsState();
// }
//
// class _ListPostsState extends State<ListPosts> {
//   @override
//   Widget build(BuildContext context) {
//     List<PostModel> posts = Provider.of<List<PostModel>>(context) ?? [];
//
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts[index];
//         return ListTile(
//           title: Text(post.creator),
//           subtitle: Text(post.text),
//         );
//       },
//     );
//   }
// }