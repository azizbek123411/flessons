import 'package:app1/riverpod/future/future_model.dart';
import 'package:app1/riverpod/future/future_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// service provider
final serviceProvider = Provider((ref) => FutureService());



final futureProvider = FutureProvider<List<FutureModel>>((ref)  {
  final repository = ref.watch(serviceProvider);
  return  repository.getUsers();
});


final createFuture=FutureProvider.family<FutureModel,FutureModel>((ref,model){
  final res=ref.watch(serviceProvider);
  return res.createFuture(model);
});

final editFuture=FutureProvider.family<FutureModel,FutureModel>((ref,model){
  final res=ref.read(serviceProvider);
  return res.updateFuture(model);
});

final deleteFuture=FutureProvider.family<void,int>((ref,id){
  final res=ref.read(serviceProvider);
  return res.deleteFuture(id);
});