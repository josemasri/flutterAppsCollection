import 'package:flutter/material.dart';
import 'package:musicplayer/src/models/audioplayer_model.dart';

import 'package:musicplayer/src/pages/music_player_page.dart';
import 'package:musicplayer/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AudioPlayerModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: MusicPlayerPage(),
        theme: miTema,
      ),
    );
  }
}
