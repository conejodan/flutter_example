import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/providers/users_provider.dart';
import 'package:flutter_hello/screens/app/screens.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  static String route = "/app-users";

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                print("Reload");
                usersProvider.getUsers();
              },
              icon: const Icon(
                Icons.replay,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: usersProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: usersProvider.users.length,
              itemBuilder: (_, index) {
                print(index);
                final user = usersProvider.users[index];
                return ListTile(
                  onTap: () {
                    final usersProvider =
                        Provider.of<UsersProvider>(context, listen: false);
                    usersProvider.selectedUser = user;
                    Navigator.of(context).pushNamed(UsersFormScreen.route);
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          final action = user.active ? 'disable' : 'enable';
                          return AlertDialog(
                            title: Text(action.toUpperCase()),
                            content: Text('Do you want to $action this user?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  print('Cancel');
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      user.active ? Colors.red : Colors.green,
                                ),
                                child: Text(action.toUpperCase()),
                              ),
                            ],
                          );
                        });
                  },
                  title: Text(user.name),
                  subtitle: Text(user.username),
                  leading: Icon(
                    Icons.circle,
                    color: user.active ? Colors.green : Colors.red,
                  ),
                  trailing: Icon(Icons.chevron_right),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final usersProvider =
              Provider.of<UsersProvider>(context, listen: false);
          usersProvider.selectedUser = User();
          Navigator.of(context).pushNamed(UsersFormScreen.route);
        },
      ),
    );
  }
}
