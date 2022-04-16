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
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // final user = FirebaseAuth.instance.currentUser;
                // if (user?.emailVerified ?? false) {
                //   print("Verified user");
                // } else {
                //   return const VerifyEmailView();
                // }
                return const LoginView();

              default:
                return Scaffold(
                  body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.description,
                            size: 100,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Loading...",
                                style: TextStyle(fontSize: 25)),
                          ),
                          CircularProgressIndicator(),
                        ]),
                  ),
                );
            }
          }),
    );
  }
}
