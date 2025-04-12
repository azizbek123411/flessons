import 'package:app1/riverpod/riverapi/post_model.dart';
import 'package:app1/riverpod/riverapi/post_repository.dart';
import 'package:app1/riverpod/riverapi/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PostNotifier extends StateNotifier<List<PostModel>>{
// final PostService postService;
// PostNotifier(this.postService):super([]){
//   loadPosts();
// }
// Future<void> loadPosts()async{
//   state=await postService.getPosts();
// }
// Future<void> addPost(PostModel post)async{
//   final newPost=await postService.createPost(post);
//   state=[newPost,...state,];
// }
// Future<void> editPost(PostModel post)async{
//   final updatePost=await postService.updatePost(post);
//   state=state.map((e)=>e.id==post.id?updatePost:e).toList();
// }
// Future<void> removePost(int id)async{
//   await postService.deletePost(id);
//   state=state.where((e)=>e.id!=id).toList();
// }
// }
// final postServiceProvider=Provider((ref)=>PostService());
// final postProvider=StateNotifierProvider<PostNotifier,List<PostModel>>((ref){
//   return PostNotifier(ref.watch(postServiceProvider),);
// });







// final postServiceProvider = Provider((ref) => PostService());




// final postProvider =
//     AsyncNotifierProvider<PostNotifier, List<PostModel>>(PostNotifier.new);

// class PostNotifier extends AsyncNotifier<List<PostModel>> {
//   late final PostService _service;

//   Future<List<PostModel>> build() async {
//     _service = ref.read(postServiceProvider);
//     return await _service.getPosts();
//   }

//   Future<void> addPost(PostModel post) async {
//     final newPost = await _service.createPost(post);
//     state = AsyncData([newPost, ...state.value!]);
//   }

//   Future<void> editPost(PostModel post) async {
//     final updated = await _service.updatePost(post);
//     state = AsyncData(
//       state.value!.map((e) => e.id == updated.id ? updated : e).toList(),
//     );
//   }

//   Future<void> deletePost(int id) async {
//     await _service.deletePost(id);
//     state = AsyncData(
//       state.value!.where((e) => e.id != id).toList(),
//     );
//   }

//   Future<void> refreshPosts() async {
//     state = const AsyncLoading();
//     state = AsyncData(await _service.getPosts());
//   }
// }






final postServiceProvider=Provider((ref)=>PostService());
/// REPOSITORY QILINDGANDA
final postRepositoryProvider = Provider((ref) {
  final service = ref.read(postServiceProvider);
  return PostRepository(service);
});
final postProvider=AsyncNotifierProvider<PostNotifier,List<PostModel>>(PostNotifier.new);

class PostNotifier extends AsyncNotifier<List<PostModel>>{
  late PostRepository repo;
  @override
  Future<List<PostModel>>build()async{
    repo=ref.read(postRepositoryProvider);
    return await repo.getPosts();
  }


  Future<void> addPost(PostModel post)async{
    final newPost=await repo.addPost(post);
    state=AsyncData([newPost,...state.value!]);
  }


  Future<void> editPost(PostModel post)async{
    final updated=await repo.editPost(post);
    state=AsyncData([
      for(final p in state.value!)
        if(p.id==updated.id) updated else p,
    ]);
  }

  Future<void> deletePost(int id)async{
    await repo.deletePost(id);
    state=AsyncData(
      state.value!.where((e)=>e.id!=id).toList(),
    );
  }
  
  Future<void> refreshPosts()async{
    state=const AsyncLoading();
    state=AsyncData(await repo.getPosts());
  }
  
  }

