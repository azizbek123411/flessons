import 'package:app1/provider/jsonplaceholder_api/api_provider.dart';
import 'package:app1/provider/jsonplaceholder_api/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiHome extends StatefulWidget {
  const ApiHome({super.key});

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  @override
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
  }

  void _addUser() async {
    if (textController.text.isEmpty) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider
        .addUser(textController.text, {'age': 25, 'city': 'Tashkent'});
    textController.clear();
  }

  void _updateUser(UserModel user) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.updateUser(
      user.id,
      "Azizbek",
      {"age": 200, "city": "Bukhara"},
    );
  }

  void deleteUser(String id) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.deleteUSer(id);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.users;
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: userProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  
                  title: Text(
                    user.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(user.data.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => deleteUser(user.id.toString()),
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _updateUser(user),
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add User'),
                content: TextField(
                  controller: textController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _addUser();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            }),
        child: Icon(Icons.add),
      ),
    );
  }
}
