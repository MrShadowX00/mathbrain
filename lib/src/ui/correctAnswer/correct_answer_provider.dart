import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathbrain/src/data/models/correct_answer.dart';
import 'package:mathbrain/src/core/app_constant.dart';
import 'package:mathbrain/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class CorrectAnswerProvider extends GameProvider<CorrectAnswer> {
  late String result;
  int? level;
  BuildContext? context;

  CorrectAnswerProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.CORRECT_ANSWER,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayerCustom audioPlayer = new AudioPlayerCustom(context!);

    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        audioPlayer.setSound();
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount = rightCount + 1;
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.setSound();
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }

    // if (timerStatus != TimerStatus.pause) {
    //   result = answer;
    //   notifyListeners();
    //   if (int.parse(result) == currentState.answer) {
    //     audioPlayer.playRightSound();
    //
    //     await Future.delayed(Duration(milliseconds: 300));
    //     loadNewDataIfRequired(level: level==null?null:level);
    //     if (timerStatus != TimerStatus.pause) {
    //       restartTimer();
    //     }
    //     notifyListeners();
    //   } else {
    //     audioPlayer.playWrongSound();
    //     wrongAnswer();
    //   }
    // }
  }
}
