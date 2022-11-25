import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/user_form_provider.dart';
import 'package:flutter_hello/providers/users_provider.dart';
import 'package:flutter_hello/services/my_server.dart';
import 'package:provider/provider.dart';

class UsersFormScreen extends StatelessWidget {
  const UsersFormScreen({super.key});

  static String route = "/app-users-form";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (_) => UserFormProvider(userProvider.selectedUser),
          child: const UserForm(),
        ),
      ),
    );
  }
}

class UserForm extends StatelessWidget {
  const UserForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserFormProvider>(context);
    final user = userForm.user;

    return Form(
      key: userForm.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: user.name,
            decoration: InputDecoration(labelText: 'Name', errorText: null),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            onSaved: (value) => user.name = value!,
          ),
          TextFormField(
            initialValue: user.username,
            decoration: InputDecoration(labelText: 'User Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            onSaved: (value) => user.username = value!,
          ),
          TextFormField(
            initialValue: user.password,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (user.id == null) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
              }

              return null;
            },
            obscureText: true,
            onSaved: (value) => user.password = value!,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: userForm.isLoading
                  ? null
                  : () async {
                      if (userForm.validate()) {
                        final usersProvider = Provider.of<UsersProvider>(
                          context,
                          listen: false,
                        );
                        if (user.id == null) {
                          // Create a new User
                          userForm.isLoading = true;
                          final response =
                              await MyServer().createUser(user);
                          if (response) {
                            await usersProvider.getUsers();
                            userForm.isLoading = false;
                            Navigator.of(context).pop();
                          }
                        } else {
                          // Update a User
                          userForm.isLoading = true;
                          final response =
                              await MyServer().updateUser(user);
                          if (response) {
                            await usersProvider.getUsers();
                            userForm.isLoading = false;
                            Navigator.of(context).pop();
                          }
                          userForm.isLoading = false;
                          // Navigator.of(context).pop();
                        }
                      }
                    },
              child: userForm.isLoading
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(user.id == null ? 'Create' : 'Update'),
            ),
          ),
        ],
      ),
    );
  }
}
