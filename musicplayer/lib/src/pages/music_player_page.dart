import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/src/helpers/helpers.dart';
import 'package:musicplayer/src/models/audioplayer_model.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            children: <Widget>[
              CustomAppBar(),
              ImageDiscDuration(),
              TitlePlay(),
              Expanded(child: Lyrics())
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ],
        ),
      ),
    );
  }
}

class Lyrics extends StatefulWidget {
  @override
  _LyricsState createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {
  ScrollController controller;
  List<Lyrics> lyrics;
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    return FutureBuilder(
      future:
          getLyrics2('assets/lrc/I_Dont_Wanna_Miss_A_Thing_by_Aerosmith.lrc'),
      builder: (BuildContext context, AsyncSnapshot<List<Lyric>> snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        final lyrics = snapshot.data;
        int currentLyric = 0;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: ListView.builder(
            itemExtent: 50,
            reverse: true,
            controller: controller,
            physics: BouncingScrollPhysics(),
            itemCount: lyrics.length,
            itemBuilder: (BuildContext context, int index) {
              return Consumer<AudioPlayerModel>(
                builder: (BuildContext context, AudioPlayerModel value,
                    Widget child) {
                  final audioPlayerModel2 =
                      Provider.of<AudioPlayerModel>(context);
                  for (var i = 0; i < lyrics.length - 1; i++) {
                    if (lyrics[i].duration < audioPlayerModel2.current &&
                        lyrics[i + 1].duration > audioPlayerModel2.current) {
                      currentLyric = i;
                    }
                  }
                  if (controller != null) {
                    controller.jumpTo(currentLyric * 50.0);
                  }
                  return ListTile(
                    title: Text(
                      lyrics[index].text,
                      style: TextStyle(
                        fontSize: 20,
                        color: (currentLyric == index)
                            ? Colors.yellow
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class TitlePlay extends StatefulWidget {
  @override
  _TitlePlayState createState() => _TitlePlayState();
}

class _TitlePlayState extends State<TitlePlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController controller;

  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        microseconds: 500,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    assetAudioPlayer
        .open(Audio("assets/mp3/Aerosmith - I Don't Want to Miss a Thing.mp3"));

    assetAudioPlayer.currentPosition.listen((Duration duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((Playing playing) {
      print(playing);
      audioPlayerModel.songDuration = playing.audio.duration;
      print(audioPlayerModel.songDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(
      context,
      listen: false,
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      margin: EdgeInsets.only(
        top: 40,
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "I Don't Want to Miss a Thing",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                '-Aerosmith-',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.5),
                ),
              )
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Color(0xffF8CB51),
            child: AnimatedIcon(
                icon: AnimatedIcons.play_pause, progress: controller),
            onPressed: () {
              if (isPlaying) {
                controller.reverse();
                isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                controller.forward();
                isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if (firstTime) {
                this.open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 70),
      child: Row(
        children: <Widget>[
          DiscImage(),
          SizedBox(
            width: 20,
          ),
          ProgressBar(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10);
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final percentage = audioPlayerModel.percentage;
    return Container(
      child: Column(
        children: <Widget>[
          Text('${audioPlayerModel.songTotalDuration}', style: style),
          SizedBox(height: 10),
          Stack(
            children: <Widget>[
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 230 * percentage,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('${audioPlayerModel.currentDuration}', style: style),
        ],
      ),
    );
  }
}

class DiscImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(
      context,
      listen: false,
    );
    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SpinPerfect(
              controller: (controller) =>
                  audioPlayerModel.controller = controller,
              duration: Duration(seconds: 1),
              infinite: true,
              manualTrigger: true,
              child: Image(image: AssetImage('assets/aerosmith.jpg')),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0Xff1C1C25),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff485750),
            Color(0xff1E1C24),
          ],
        ),
      ),
    );
  }
}
