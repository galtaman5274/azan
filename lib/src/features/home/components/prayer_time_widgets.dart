
import 'package:flutter/material.dart';

// Prayer Time Item Widget
class PrayerTimeItemWidget extends StatelessWidget {
  final String prayerName;
  final String prayerTime;

  const PrayerTimeItemWidget({
    super.key,
    required this.prayerName,
    required this.prayerTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 55,
      decoration: BoxDecoration(
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
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors
                    .brown, // Text color for better contrast on image background
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              prayerTime,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black, // Text color for better visibility
              ),
            ),
          ],
        ),
      ),
    );
  }
}