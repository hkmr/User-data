import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_form/data/Users.dart';
import 'package:user_form/models/User.dart';

class UserDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: SafeArea(
        child: Consumer<Users>(
          builder: (context, users, child) {
            List<User> _users = users.getUsers();
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_users[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_users[index].phone.toString()),
                      Text(_users[index].email),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(context, index);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  _deleteUser(BuildContext context, int index) {
    Provider.of<Users>(context, listen: false).removeUser(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'User Deleted',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
