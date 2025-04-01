import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiService extends ChangeNotifier {
  final String apiUrl = 'https://api.restful-api.dev/objects';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List products = [];

  Future<List> getObjects() async {
    _isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(apiUrl));

    print(response.statusCode);
    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      products = datas.map((json) => ObjectModel.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
      return products;
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load objects');
    }
  }
}

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  @override
  initState() {
    super.initState();
    Provider.of<ApiService>(context,listen: false).getObjects();
  }

  @override
  Widget build(BuildContext context) {
    final apiservice = Provider.of<ApiService>(context,);
    return Scaffold(
      appBar: AppBar(
        title: Text('API Home'),
      ),
      body: apiservice._isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: apiservice.products.length,
              itemBuilder: (context, index) {
                final item = apiservice.products[index];
                return ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(item.data.toString()),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ApiService>(context, listen: false).getObjects();
          print(context.read<ApiService>().products[1].name);
        },
      ),
    );
  }
}

class ObjectModel {
  final String id;
  final String name;
  final Map<String, dynamic> data;

  ObjectModel({
    required this.id,
    required this.name,
    required this.data,
  });

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      id: json['id'],
      name: json['name'],
      data: json['data'] ?? {},
    );
  }
}
