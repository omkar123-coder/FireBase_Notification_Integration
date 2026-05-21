import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification_1/controller/google_login_controller.dart';
import 'package:flutter/material.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Google Sign In"),
              actions: [
                IconButton(
                  onPressed: () => GoogleLoginController().signOut(),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (snapshot.data!.photoURL != null)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(snapshot.data!.photoURL!),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    snapshot.data!.displayName ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(snapshot.data!.email ?? ""),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Google Login"),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () => GoogleLoginController().signInWithGoogle(),
              child: const Text("Sign In with Google"),
            ),
          ),
        );
      },
    );
  }
}
