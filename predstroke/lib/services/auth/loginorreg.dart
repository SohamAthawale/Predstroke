import 'package:flutter/material.dart';
import 'package:predstroke/pages/login_page.dart';
import 'package:predstroke/pages/register_page.dart';

class loginorreg extends StatefulWidget {
  const loginorreg({super.key});

  @override
  State<loginorreg> createState() => _loginorregState();
}

class _loginorregState extends State<loginorreg> {
  bool showloginpage = true;
  void togglepage() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return LoginPage(onTap: togglepage);
    } else {
      return Registerview(onTap: togglepage);
    }
  }
}
