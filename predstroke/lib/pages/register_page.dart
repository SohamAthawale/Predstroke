import 'package:flutter/material.dart';
import 'package:predstroke/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import '../components/button_tap.dart';
import '../components/text_feild.dart';

class Registerview extends StatefulWidget {
  final void Function()? onTap;
  const Registerview({super.key, required this.onTap});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final repasscontroller = TextEditingController();

  void signup() async {
    if (passcontroller.text != repasscontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords dont match+")));
      return;
    }

    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      await authservice.signUpWithEmailAndPassword(
          emailcontroller.text, passcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100,
                          ),
                          child: Image.asset(
                            'assets/logo1.png',
                            height: 100,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "Let's Create a Account for You!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyTestfeild(
                            controller: emailcontroller,
                            hintText: 'Enter email',
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MyTestfeild(
                            controller: passcontroller,
                            hintText: 'Enter password',
                            obscureText: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MyTestfeild(
                            controller: repasscontroller,
                            hintText: 'retype password',
                            obscureText: true),
                      ),
                      Buttontap(onTap: signup, text: 'Sign up'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already a Member?'),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Login now!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
