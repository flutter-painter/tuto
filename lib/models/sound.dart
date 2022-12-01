import 'package:just_audio/just_audio.dart';

final List<AudioSource> audioSource = [
  AudioSource.uri(Uri(
    scheme: 'asset',
    path: 'assets/congratulations.mp3',
  )),
];

class Sound {
  static playSound(String path) {
    final player = AudioPlayer();
    player
        .setAsset(path)
        .then((_) => player.play().then((_) => player.dispose()));
  }
}
