import 'package:audioplayers/audioplayers.dart';

class AudioHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String url;

  AudioHandler(this.url);

  Future<void> play() async {
    await _audioPlayer.play(DeviceFileSource(url));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  Stream<Duration> get onProgress => _audioPlayer.onPositionChanged;
}
