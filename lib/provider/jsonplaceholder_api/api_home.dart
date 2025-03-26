import 'package:app1/provider/jsonplaceholder_api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiHome extends StatefulWidget {
  const ApiHome({super.key});

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  @override
  void initState() {
    super.initState();
        Provider.of<UserProvider>(context,listen: false).fetchUsers();

  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: userProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return ListTile(
                  title: Text(user.name,style: TextStyle(color: Colors.black),),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    onPressed: () {
                      userProvider.deleteUser(user.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserDialog(context, userProvider);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context, UserProvider userProvider) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  userProvider.addUser(
                      nameController.text, emailController.text);
                  Navigator.pop(context);
                },
                child: Text('Add'),
              )
            ],
          );
        });
  }
}
