import 'package:flutter/material.dart';

// Prayer Time Item Widget
class ScreenPrayerTime extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final bool hasPassed;
  final bool screenSaver;

  const ScreenPrayerTime({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.hasPassed,
    required this.screenSaver,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: screenSaver==true? 60:100,
      decoration: BoxDecoration(
        color: hasPassed ? Colors.grey : const Color.fromARGB(255, 177, 146, 135), // Change color if prayer has passed
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:screenSaver==true ? 5:10),

            Text(
              prayerName.toUpperCase(),
              style:  TextStyle(
                fontSize: screenSaver==true ? 18:20,
                fontWeight: FontWeight.bold,
              color: hasPassed ? const Color.fromARGB(255, 80, 237, 23) : Colors.white, // Optional: Change text color
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              prayerTime,
              style: TextStyle(
                fontSize: screenSaver == true ? 12:17,
                color: Colors.white, // Text color for better visibility
              ),
            ),
          ],
        ),
      ),
    );
  }
}
