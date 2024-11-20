import 'package:predstroke/components/drawer.dart';
import 'package:predstroke/components/textbox.dart';
import 'package:predstroke/pages/orderspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class Profileview extends StatefulWidget {
  const Profileview({super.key});

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  Future<void> editfeild(String feild) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: Text(
                "Enter new $feild",
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $feild",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: Text("Save"))
              ],
            ));
  }

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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 120.0),
                  /* child: Image.asset(
                  'assets/logo1.png',
                  alignment: Alignment.center,
                ),*/
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              IconButton(
                  onPressed: signOut, icon: const Icon(Icons.logout_rounded)),
            ],
          )
        ],
      ),
      drawer: Mydrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.person,
            size: 70,
          ),
          Text(
            currentuser.email!,
            textAlign: TextAlign.center,
            textScaleFactor: 1.1,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Mytextbox(
            sectionname: "Username",
            text: 'hello1234',
            onPressed: () => editfeild('username'),
          ),
          Mytextbox(
            sectionname: "Contact number",
            text: '1234567890',
            onPressed: () => editfeild('contact no'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Orderspage())),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                        child: Text(
                      "Parking History",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
