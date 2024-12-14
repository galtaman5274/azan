import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../../app/screen_saver/main_provider.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool turnOff;
  final String nav;
  const MainButton(
      {super.key,  required this.text, this.turnOff = false,required this.nav});

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
          provider.resetInactivityTimer();
        }
      },
      child: Container(

        width: 30.w, // Set the desired width of the button
        height: 30.h, // Set the desired height of the button
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.brown// Rounded corners
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            text, // Your button text
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white, // Text color for better contrast
            ),
          ),
        ),
      ),
    );
  }
}
