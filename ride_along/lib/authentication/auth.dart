import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ride_along/screens/Registration/RegistrationScreen.dart';
import 'package:ride_along/screens/email_verification/email_verification_screen.dart';
import 'package:ride_along/screens/home/home.dart';
import 'package:ride_along/screens/loading/loading.dart';
import 'package:ride_along/screens/login/login.dart';

import '../firebase_options.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/chat/messages_screen.dart';

class Auth extends StatefulWidget {
  Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      setState(() {
        initialized = true;
      });
    });
    if (!initialized) {
      return LoadingScreen();
    } else {
      return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (FirebaseAuth.instance.currentUser?.emailVerified == false) {
                return EmailVerificationScreen();
              }
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      );
    }
  }
}
