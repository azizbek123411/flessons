import 'package:app1/riverpod/future/future_model.dart';
import 'package:app1/riverpod/future/future_service.dart';

class FutureRepository {
  final FutureService service;
  FutureRepository({required this.service});

  Future<List<FutureModel>> getUsers() => service.getUsers();
  Future<FutureModel> updateFuture(FutureModel model)=>service.updateFuture(model);
  Future<FutureModel> createFuture(FutureModel model)=>service.createFuture(model);
  Future<void>deleteFuture(int id)=>service.deleteFuture(id);
}
