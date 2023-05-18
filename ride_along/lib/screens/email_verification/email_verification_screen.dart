import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../constants/is_dark.dart';

class EmailVerificationScreen extends StatefulWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }

    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // TODO: implement your code after email verification
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email Successfully Verified")));

      timer?.cancel();

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var _isDark = isDark(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title:  Text('Hiking Buddy'),
        //   actions: [
        //     IconButton(onPressed: signUserOut, icon:  Icon(Icons.logout))
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                      color: _isDark ? kTextColorLight : kBackgroundColorDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email on  ${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: _isDark ? kTextColorLight : kBackgroundColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: CircularProgressIndicator(
                color: _isDark ? kTextColorLight : kBackgroundColorDark,
              )),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: _isDark ? kTextColorLight : kBackgroundColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: _isDark
                            ? MaterialStateProperty.all<Color>(kTextColorLight)
                            : MaterialStateProperty.all<Color>(
                                kBackgroundColorDark),
                      ),
                      child: Text(
                        'Resend',
                        style: GoogleFonts.ubuntu(
                          color:
                              !_isDark ? kTextColorLight : kBackgroundColorDark,
                        ),
                      ),
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();
                        } catch (e) {
                          debugPrint('$e');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: _isDark
                            ? MaterialStateProperty.all<Color>(kTextColorLight)
                            : MaterialStateProperty.all<Color>(
                                kBackgroundColorDark),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.ubuntu(
                          color:
                              !_isDark ? kTextColorLight : kBackgroundColorDark,
                        ),
                      ),
                      onPressed: signUserOut,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
