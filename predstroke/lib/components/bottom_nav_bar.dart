import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Mybottomnavbar extends StatelessWidget {
  const Mybottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GNav(
          color: Colors.grey.shade400,
          activeColor: Colors.grey.shade700,
          tabActiveBorder: Border.all(color: Colors.white),
          tabBackgroundColor: Colors.grey.shade100,
          tabBorderRadius: 20,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabMargin: const EdgeInsets.all(10),
          tabs: const [
            GButton(
              icon: Icons.map_outlined,
              text: 'Map',
            ),
            GButton(
              icon: Icons.location_on,
              text: 'location',
            )
          ]),
    );
  }
}
