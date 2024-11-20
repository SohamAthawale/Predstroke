import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EmailCheck extends StatefulWidget {
  const EmailCheck({super.key});

  @override
  State<EmailCheck> createState() => _EmailCheckState();
}

class _EmailCheckState extends State<EmailCheck> {
  // Future emailcheck() async {
  //   try {
  //     await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text(e.message.toString()),
  //           );
  //         });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
