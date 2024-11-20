import 'package:predstroke/components/listtile.dart';
import 'package:predstroke/pages/home_page.dart';
import 'package:predstroke/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/profile_view.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  void signOut() async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      await authservice.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: DrawerHeader(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Listtile(
                    icon: Icons.home,
                    text: 'H O M E',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Listtile(
                    icon: Icons.person,
                    text: 'P R O F I L E',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profileview()))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 20),
            child: Listtile(
                icon: Icons.logout, text: 'L O G O U T', onTap: signOut),
          ),
        ],
      ),
    );
  }
}
