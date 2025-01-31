import 'package:azan/app/navigation/cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

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
    _playAdhan(
        'https://app.ayine.tv/Ayine/AzanFiles/Turkish/03-Dhuhr/001.mp4'); // Start playing Adhan when the page opens
  }

  Future<void> _playAdhan(String urlSource) async {
    await _audioPlayer.play(UrlSource(urlSource)); // Ensure the path is correct
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
                  context.read<NavigationCubit>().setPage('home');
                  _audioPlayer.stop(); // Stop the audio when the page is closed
                  _audioPlayer.dispose(); // Release resources
                }),
          ),
        ],
      ),
    );
  }
}
