import 'package:app1/provider/jsonplaceholder_api/api_provider.dart';
import 'package:app1/provider/jsonplaceholder_api/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiHome extends StatelessWidget {
  const ApiHome({super.key});

  @override
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
                      nameController.text, {});
                  Navigator.pop(context);
                },
                child: Text('Add'),
              )
            ],
          );
        });
  }

 void _showEditUserDialog(BuildContext context, UserProvider userProvider, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
              TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Update"),
              onPressed: () {
                // userProvider.updateUser(user.id, nameController.text, emailController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body:
         
          ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return ListTile(
                  onTap: () => _showEditUserDialog(context,userProvider, user),
                  title: Text(
                    user.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(user.email),
                  trailing: IconButton(
                    onPressed: () {
                      // userProvider.deleteUser(user.id);
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
}
