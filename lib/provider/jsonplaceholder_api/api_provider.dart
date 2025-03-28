import 'dart:convert';

import 'package:app1/provider/jsonplaceholder_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier{
  final String apiUrl='https://api.restful-api.dev/objects';
   List<UserModel> _users=[];

  List<UserModel> get users=>_users;



  /// GET
  
  Future<void> fetchUsers()async{
    final response=await http.get(Uri.parse(apiUrl),);
    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      _users=data.map((json)=>UserModel.fromJson(json)).toList();
      notifyListeners();
    }else{
      throw Exception('Failed to load users');
    }
  }


  /// POST
  
  Future<void> addUser(String name,Map<String,dynamic> data)async{
    final response=await http.post(Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"name":name,"data":data}), );

    if(response.statusCode==200||response.statusCode==201){
      UserModel newUser=UserModel.fromJson(jsonDecode(response.body));
      _users.add(newUser);
      notifyListeners();
    }else{
      throw Exception("Failed to add user");
    }
  }


  
}