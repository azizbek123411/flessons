import 'package:app1/riverpod/riverapi/post_model.dart';
import 'package:app1/riverpod/riverapi/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostNotifier extends StateNotifier<List<PostModel>>{

final PostService postService;
PostNotifier(this.postService):super([]){
  loadPosts();
}


Future<void> loadPosts()async{
  state=await postService.getPosts();
}

Future<void> addPost(PostModel post)async{
  final newPost=await postService.createPost(post);
  state=[newPost,...state,];
}

Future<void> editPost(PostModel post)async{
  final updatePost=await postService.updatePost(post);
  state=state.map((e)=>e.id==post.id?updatePost:e).toList();
}

Future<void> removePost(int id)async{
  await postService.deletePost(id);
  state=state.where((e)=>e.id!=id).toList();
}

}


final postServiceProvider=Provider((ref)=>PostService());

final postProvider=StateNotifierProvider<PostNotifier,List<PostModel>>((ref){
  return PostNotifier(ref.watch(postServiceProvider),);
});