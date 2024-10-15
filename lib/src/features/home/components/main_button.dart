import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../main/main_provider.dart';

class MainButton extends StatelessWidget {
  final String img;
  final String text;
  final bool turnOff;
  const MainButton(
      {super.key, required this.img, required this.text, this.turnOff = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (turnOff) {
SystemNavigator.pop();
        } else {
          final provider =
              Provider.of<NavigationProvider>(context, listen: false);
          provider.navigateTo(text);
          provider.screenSaverController?.resetInactivityTimer();
        }
      },
      child: Container(
        width: 80, // Set the desired width of the button
        height: 50, // Set the desired height of the button
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/$img.png'), // Background image path
            fit: BoxFit.cover, // Cover the entire button area
          ),
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Center(
          child: Text(
            text, // Your button text
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown, // Text color for better contrast
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                  color: Colors.black45, // Optional text shadow for visibility
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
