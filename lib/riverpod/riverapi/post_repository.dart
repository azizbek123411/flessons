import 'package:app1/riverpod/riverapi/post_model.dart';
import 'package:app1/riverpod/riverapi/post_service.dart';

class PostRepository {
  final PostService service;

  PostRepository(this.service);

  Future<List<PostModel>> getPosts()=>service.getPosts();
  Future<PostModel> addPost(PostModel post)=>service.createPost(post);
  Future<PostModel> editPost(PostModel post)=>service.updatePost(post);
  Future<void> deletePost(int id)=>service.deletePost(id);
}