import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/global_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    final loggedUser = globalState.loggedUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Change Username'),
            subtitle: Text(loggedUser.username),
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text('Change Full Name'),
            subtitle: Text(loggedUser.fullName),
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text('Change Password'),
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            leading: Icon(Icons.lock),
          )
        ],
      ),
    );
  }
}
