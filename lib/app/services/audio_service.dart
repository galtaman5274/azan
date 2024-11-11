// services/adhan_audio_service.dart
import 'package:audioplayers/audioplayers.dart';

class AdhanAudioService {
  final AudioPlayer _audioPlayer;
  AdhanAudioService(this._audioPlayer);

  Future<void> playAdhan() async {
    try {
      await _audioPlayer.play(AssetSource('audio/adhan.mp3'));
    } catch (e) {
      print("Error playing Adhan audio: $e");
    }
  }

  void stopAdhan() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
