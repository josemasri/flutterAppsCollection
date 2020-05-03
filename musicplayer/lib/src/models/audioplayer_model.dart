import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  AnimationController controller;
  FixedExtentScrollController listController =
      FixedExtentScrollController(initialItem: 0);

  bool _playing = false;
  Duration _songDuration = Duration(microseconds: 0);
  Duration _current = Duration(microseconds: 0);

  String get songTotalDuration => this.printDuration(_songDuration);

  String get currentDuration => this.printDuration(_current);

  double get percentage => (_current.inSeconds > 0)
      ? _current.inSeconds / _songDuration.inSeconds
      : 0;

  bool get playing => _playing;
  set playing(bool value) {
    _playing = value;
    notifyListeners();
  }

  get songDuration => _songDuration;

  set songDuration(Duration value) {
    _songDuration = value;
    notifyListeners();
  }

  get current => _current;

  set current(Duration value) {
    _current = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
