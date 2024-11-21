import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../../app/screen_saver/main_provider.dart';

class MainButton extends StatelessWidget {
  final String img;
  final String text;
  final bool turnOff;
  final String nav;
  const MainButton(
      {super.key, required this.img, required this.text, this.turnOff = false,required this.nav});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (turnOff) {
          SystemNavigator.pop();
        } else {
          final provider =
              Provider.of<NavigationProvider>(context, listen: false);
          provider.navigateTo(nav);
          provider.screenSaverController?.resetInactivityTimer();
        }
      },
      child: Container(
        width: 30.w, // Set the desired width of the button
        height: 60.h, // Set the desired height of the button
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/$img.png'), // Background image path
            fit: BoxFit.cover, // Cover the entire button area
          ),
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            text, // Your button text
            style: const TextStyle(
              fontSize: 14,
              color: Colors.orange, // Text color for better contrast
            ),
          ),
        ),
      ),
    );
  }
}
