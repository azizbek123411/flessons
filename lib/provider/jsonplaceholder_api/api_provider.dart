import 'dart:convert';
import 'dart:developer';

import 'package:app1/provider/jsonplaceholder_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<UserModel> users = [];
  bool isLoading = false;
  final String apiUrl = "https://jsonplaceholder.typicode.com/users";

  /// GET

  Future<void> fetchUsers() async {
    isLoading = true;
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      final users = data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Foydalanuvchi olishda xatolik');
    }
    isLoading = false;
    notifyListeners();
  }

  /// POST

  Future<void> addUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email}),
    );

    if (response.statusCode == 201) {
      final newUser = UserModel.fromJson(jsonDecode(response.body));
      users.add(newUser);
      notifyListeners();
    } else {
      throw Exception("Foydalanuvchi qo'shishda xatolik");
    }
  }

  /// PUT

  Future<void> updateUser(int id, String name, String email) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": name, "body": email}),
    );
print("Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final updatedUser = UserModel.fromJson(jsonDecode(response.body));
      int index = users.indexWhere((user) => user.id == id);
      if (index != -1) {
        users[index] = updatedUser;
        notifyListeners();
      }
    } else {
      throw Exception("Foydalanuvchi malumotlarini yangilashda xatolik yuz berdi!",);
    }
  }


  ///DELETE
  
  Future<void> deleteUser(int id)async{
    final response=await http.delete(Uri.parse("$apiUrl/$id"));

    if(response.statusCode==200){
      users.removeWhere((user)=>user.id==id);
      notifyListeners();
    }else{
      throw Exception("Foydalanuvchini o'chirishda xatolik");
    }
  }

}
