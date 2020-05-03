import 'package:flutter/services.dart' show rootBundle;

List<String> getLyrics() {
  return [
    'Hope stopped the heart',
    'Lost beaten lie',
    'Cold walk the earth',
    'Love faded white',
    'Gave up the war',
    'I\'ve realized',
    'All will become',
    'All will arise',
    'Stay with me',
    'I hear them call the tide',
    'Take me in',
    'I see the last divide',
    'Hopelessy',
    'I leave this all behind',
    'And I am paralyzed',
    'When the broken fall alive',
    'Let the light take me too',
    'When the waters turn to fire',
    'Heaven, please let me through',
    'Far away, far away',
    'Sorrow has left me here',
    'Far away, far away',
    'Let the light take me in',
    'Fight back the flood',
    'One breath of life',
    'God, take the earth',
    'Forever blind',
    'And now the sun will fade',
    'And all we are is all we made',
    'Stay with me',
    'I hear them call the tide',
    'Take me in',
    'I see the last divide',
    'Hopelessy',
    'I leave this all behind',
    'And I am paralyzed',
    'When the broken fall alive',
    'Let the light take me too',
    'When the waters…'
  ];
}

Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

class Lyric {
  final Duration duration;
  final String text;

  Lyric(this.duration, this.text);
}

Future<List<Lyric>> getLyrics2(String fileName) async {
  final List<Lyric> lyrics = [];
  String data = await getFileData(fileName);

  data.split('\n').forEach((line) {
    final number = line.split('[')[1].split(']')[0];
    final lyric = line.split('[')[1].split(']')[1];
    if (int.tryParse(number.split(':')[0]) != null) {
      final minutes = int.tryParse(number.split(':')[0]);
      final seconds = int.tryParse(number.split(':')[1].split('.')[0]);
      final miliseconds = int.tryParse(number.split(':')[1].split('.')[1]);
      lyrics.add(Lyric(
        Duration(
          minutes: minutes,
          seconds: seconds,
          microseconds: miliseconds,
        ),
        lyric,
      ));
    }
  });
  return lyrics;
}
