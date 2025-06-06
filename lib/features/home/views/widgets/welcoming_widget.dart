import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goddb_task/core/utils/configs/theme/theme_manager.dart';

class welcome_widget extends StatelessWidget {
  const welcome_widget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? 'Guest';
    return ListTile(
      title: Text(
        'Hello $name',
        style: Theme.of(context).textTheme.displayLarge,
      ),
      subtitle: Opacity(  opacity: 0.54,
        child: Text(
          'Have a nice day',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
