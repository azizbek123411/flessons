import 'package:app1/riverpod/riverapi/post_model.dart';
import 'package:app1/riverpod/riverapi/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PostPage extends ConsumerWidget {
//   const PostPage({super.key});
//   void _showForm(BuildContext context, WidgetRef ref,
//       {bool isEdit = false, PostModel? post}) {
//     final titleController =
//         TextEditingController(text: isEdit ? post?.title : '');
//     final bodyController =
//         TextEditingController(text: isEdit ? post?.body : '');
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(isEdit ? "Edit Post" : "Add Post"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     hintText: 'Title',
//                   ),
//                 ),
//                 TextField(
//                   controller: bodyController,
//                   decoration: InputDecoration(
//                     hintText: 'Body',
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   final newPost = PostModel(
//                       id: isEdit ? post!.id : 0,
//                       title: titleController.text,
//                       body: bodyController.text);
//                   final notifier = ref.read(postProvider.notifier);
//                   if (isEdit) {
//                     notifier.editPost(newPost);
//                   } else {
//                     notifier.addPost(newPost);
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(isEdit ? 'Edit' : "Add"),
//               ),
//             ],
//           );
//         });
//   }
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final posts = ref.watch(postProvider);
//     final postNotifier = ref.read(postProvider.notifier);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Posts"),
//       ),
//       body: posts.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(itemBuilder: (context, index) {
//               return Container(
//                 padding: EdgeInsets.all(10),
//                 margin: EdgeInsets.only(top: 5,right: 10,left: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(15)
//                 ),
//                 child: ListTile(
//                   title: Text(posts[index].title),
//                   subtitle: Text(posts[index].body),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: () => postNotifier.removePost(posts[index].id),
//                       ),
//                       IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () => _showForm(
//                                 context,
//                                 ref,
//                                 isEdit: true,
//                                 post: posts[index],
//                               )),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showForm(context, ref);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  void _showForm(
    BuildContext context,
    WidgetRef ref, {
    bool isEdit = false,
    PostModel? post,
  }) {
    final titleController = TextEditingController(text: post!.title);
    final bodyController = TextEditingController(text: post.body);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? "Edit Post" : "Add Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(hintText: "Body"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newPost = PostModel(
                  id: isEdit ? post.id : 0,
                  title: titleController.text,
                  body: bodyController.text);
              final notifier = ref.read(postProvider.notifier);
              isEdit ? notifier.editPost(newPost) : notifier.addPost(newPost);

              Navigator.pop(context);
            },
            child: Text(isEdit ? 'Edit' : "Add"),
          ),
        ],
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postProvider);
    final notifier = ref.read(postProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('Datas'), actions: [
        IconButton(
          onPressed: () => notifier.refreshPosts(),
          icon: Icon(Icons.refresh),
        ),
      ]),
      body: postsState.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () => notifier.refreshPosts(),
          child: ListView.builder(itemBuilder: (context, index) {
            final post = posts[index];
            return Container(
              margin: EdgeInsets.only(top: 5, right: 10, left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        notifier.editPost(post);
                        _showForm(context, ref, isEdit: true, post: post);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: ()  {
                        notifier.deletePost(post.id);
                        showSnackbar(context, 'Post Deleted');
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        error: (error, st) => Center(
          child: Text("Error:$error,StatckTrace:$st"),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }
}
