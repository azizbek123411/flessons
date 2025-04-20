import 'dart:convert';

import 'package:app1/riverpod/future/future_model.dart';
import 'package:http/http.dart' as http;
class FutureService {
    final baseUrl='https://jsonplaceholder.typicode.com/users';


    Future<List<FutureModel>> getUsers()async{
      final res= await http.get(Uri.parse(baseUrl));
     if(res.statusCode==200){
      final List data=jsonDecode(res.body);
      return data.map((user)=>FutureModel.fromJson(user)).toList();
     }else{
      throw Exception('failed to load users');
     }
    }
}