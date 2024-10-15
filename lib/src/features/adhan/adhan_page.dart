import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../main/main_provider.dart';

class AdhanPage extends StatefulWidget {
  const AdhanPage({super.key});

  @override
  State<AdhanPage> createState() => _AdhanPageState();
}

class _AdhanPageState extends State<AdhanPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAdhan(); // Start playing Adhan when the page opens
  }

  Future<void> _playAdhan() async {
    await _audioPlayer
        .play(AssetSource('audio/adhan.mp3')); // Ensure the path is correct
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // Stop the audio when the page is closed
    _audioPlayer.dispose(); // Release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/azan_bg.jpg'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Text at the Center
          Center(
            child: Container(
              color: Colors.black54, // Optional: Semi-transparent overlay
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Adhan is Playing...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Close Button at the Top Right
          Positioned(
            top: 40, // Adjust based on your UI
            right: 20, // Adjust based on your UI
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Colors.white),
              onPressed: () {
                // Use the provider to navigate back to the home screen
                Provider.of<NavigationProvider>(context, listen: false)
                    .navigateTo('home');
              },
            ),
          ),
          // Stop and Go Back Button at the Bottom Center
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                // Use provider to change the screen to home and stop audio
                _audioPlayer.stop();
                Provider.of<NavigationProvider>(context, listen: false)
                    .navigateTo('home');
              },
              child: const Text('Stop and Go Back'),
            ),
          ),
        ],
      ),
    );
  }
}
