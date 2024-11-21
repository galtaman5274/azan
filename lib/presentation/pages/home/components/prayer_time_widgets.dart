import 'package:flutter/material.dart';

// Prayer Time Item Widget
class PrayerTimeItemWidget extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final bool hasPassed;

  const PrayerTimeItemWidget({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.hasPassed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: hasPassed ? Colors.grey : Colors.white, // Change color if prayer has passed
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/time_frame.png',
          ), // Replace with your image path
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              prayerName,
              style:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              color: hasPassed ? Colors.grey : Colors.orange, // Optional: Change text color
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              prayerTime,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.brown, // Text color for better visibility
              ),
            ),
          ],
        ),
      ),
    );
  }
}
