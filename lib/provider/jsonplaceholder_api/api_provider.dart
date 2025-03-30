import 'dart:convert';

import 'package:app1/provider/jsonplaceholder_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  final String apiUrl = 'https://api.restful-api.dev/objects';
  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  /// GET

  Future<void> fetchUsers() async {
   
    final response = await http.get(
      Uri.parse(apiUrl),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _users = data.map((json) => UserModel.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
    _isLoading = false;
    notifyListeners();
  }

  /// POST

  Future<void> addUser(String name, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "data": data}),
    );
 print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel newUser = UserModel.fromJson(jsonDecode(response.body));
      _users.add(newUser);
      notifyListeners();
    } else {
      throw Exception("Failed to add user");
    }
  }

  /// PUT

  Future<void> updateUser(
      String id, String name, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("$apiUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {"name": name, "data": data},
      ),
    );
 print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      int index = _users.indexWhere((user) => user.id == id);
      if (index != -1) {
        _users[index] = UserModel(id: id, name: name, data: data);
        notifyListeners();
      }
    } else {
      throw Exception("Failed to update user");
    }
  }

  /// DELETE

  Future<void> deleteUSer(String id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));
    if (response.statusCode == 200) {
      _users.removeWhere((user) => user.id == id);
      notifyListeners();
    } else {
      throw Exception("Failed to delete user");
    }
  }
}
