import 'dart:convert';

import 'package:app1/riverpod/future/future_model.dart';
import 'package:http/http.dart' as http;

class FutureService {
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<FutureModel>> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((user) => FutureModel.fromJson(user)).toList();
    } else {
      throw Exception('failed to load users');
    }
  }

  Future<FutureModel> createFuture(FutureModel model) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(model.toJson()),
      headers: {'Content-Type': 'application/json'}
    );
    if (res.statusCode == 201) {
      return FutureModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('failed create data');
    }
  }

  Future<FutureModel> updateFuture(FutureModel model) async {
    final res = await http.put(
      Uri.parse('$baseUrl/${model.id}'),
      body: jsonEncode(
        model.toJson(),
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      return FutureModel.fromJson(
        jsonDecode(res.body),
      );
    } else {
      throw Exception('failed to update data');
    }
  }

  Future<void> deleteFuture(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl/$id"));
    if (res.statusCode != 200) {
      throw Exception('couldnt delete');
    }
  }
}
