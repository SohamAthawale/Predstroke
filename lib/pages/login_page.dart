import 'package:flutter/material.dart';
import 'package:predstroke/components/button_tap.dart';
import 'package:predstroke/components/text_feild.dart';
import 'package:predstroke/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  void signin() async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      await authservice.signInWithEmailAndPassword(
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
                          "Welcome back you have been missed!",
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
                      Buttontap(onTap: signin, text: 'Sign in'),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                            '------------------------------or continue with------------------------------'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => AuthService().signInwithGoogle(),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Image.asset(
                                  'assets/google.png.png',
                                  height: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Not a Member?'),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Register now!",
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
