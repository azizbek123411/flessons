import 'package:app1/riverpod/future/future_model.dart';
import 'package:app1/riverpod/future/future_service.dart';

class FutureRepository {
  final FutureService service;
  FutureRepository({required this.service});

Future<List<FutureModel>> getUsers()=>service.getUsers();
}