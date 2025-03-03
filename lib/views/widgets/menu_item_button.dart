import 'package:flutter/material.dart';

class CustomMenuItemButton extends StatelessWidget {
  final Icon icon;
  final GestureTapCallback? ontap;
  final String title;
  const CustomMenuItemButton({super.key, this.ontap, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      splashColor: Colors.grey, // Red splash
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(110, 197, 199, 200), // Background color
            borderRadius: BorderRadius.circular(20), // Rounded corners
            //border: Border.all(color: Colors.black, width: 0), // Optional border
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }
}
