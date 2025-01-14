import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathbrain/src/data/models/calculator.dart';
import 'package:mathbrain/src/core/app_constant.dart';
import 'package:mathbrain/src/ui/app/game_provider.dart';
import 'package:mathbrain/src/ui/soundPlayer/audio_file.dart';

class CalculatorProvider extends GameProvider<Calculator> {
  late String result;

  BuildContext? context;
  int? level;

  CalculatorProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.CALCULATOR,
            c: context) {
    this.level = level;
    this.context = context;
    startGame(level: this.level == null ? null : level);
  }

  bool isClick = false;

  void checkResult(String answer) async {
    AudioPlayerCustom audioPlayer = new AudioPlayerCustom(context!);
    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();

      if (int.parse(result) == currentState.answer) {
        notifyListeners();
        audioPlayer.setSound();
        audioPlayer.playRightSound();
        isClick = false;

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
        addCoin();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        minusCoin();
        audioPlayer.setSound();
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}
