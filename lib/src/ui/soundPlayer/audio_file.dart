import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:mathbrain/src/utility/Constants.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AudioPlayerCustom {
  BuildContext? context;

  AudioCache audioCache = AudioCache();
  AudioPlayer player = AudioPlayer();
  bool? _isSound = true;
  bool? _isVibrate = true;

  AudioPlayerCustom(BuildContext context) {
    this.context = context;
    setSound();
  }

  setSound() async {
    _isSound = await getSound();
    print(_isSound);
    _isVibrate = await getVibration();
  }

  void playWrongSound() {
    if (_isVibrate!) {
      Vibrate.vibrate();
    }
  }

  void playGameOverSound() {
    playAudio(gameOverSound);
  }

  void playRightSound() {
    playAudio(rightSound);
  }

  void playTickSound() {
    playAudio(tickSound);
  }

  void playAudio(String s) async {
    if (_isSound!) {
      try {
        await audioCache.loadPath(s);
        await player.play(AssetSource(s));
      } on Exception catch (_) {}
    }
  }

  void stopAudio() async {
    if (_isSound!) {
      await audioCache.clearAll();
    }
  }
}
