import 'package:flutter/material.dart';

class Mytextbox extends StatelessWidget {
  final String text;
  final String sectionname;
  final void Function()? onPressed;
  const Mytextbox(
      {super.key,
      required this.sectionname,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionname,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey.shade600,
                  size: 22,
                ))
          ],
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
