import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  

    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Logout'),
          onPressed: () {
       
          },
        ),
      ],
    );
  }
}
