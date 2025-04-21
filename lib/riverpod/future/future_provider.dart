import 'package:app1/riverpod/future/future_model.dart';
import 'package:app1/riverpod/future/future_repository.dart';
import 'package:app1/riverpod/future/future_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// service provider
final serviceProvider = Provider<FutureService>((ref) => FutureService());

final futureRepositoryProvider = Provider<FutureRepository>((ref) {
  final service = ref.watch(serviceProvider);
  return FutureRepository(service: service);
});

final futureProvider = FutureProvider<List<FutureModel>>((ref) async {
  final repository = ref.read(futureRepositoryProvider);
  return await repository.getUsers();
});


final createFuture=FutureProvider.family<FutureModel,FutureModel>((ref,model)async{
  final res=ref.read(futureRepositoryProvider);
  return res.createFuture(model);
});

final editFuture=FutureProvider.family<FutureModel,FutureModel>((ref,model)async{
  final res=ref.read(futureRepositoryProvider);
  return res.updateFuture(model);
});
