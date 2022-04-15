import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';
import 'package:notes/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Homepage(),
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  print("Verified user");
                }
                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                );
              default:
                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(fontSize: 23, color: Colors.red),
                    ),
                  ),
                );
            }
          }),
    );
  }
}
