import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'models/song.dart';
import 'widgets/scrubber.dart';
import 'widgets/sized_spacer.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({Key? key}) : super(key: key);

  static const List<Song> songs = [
    Song("Stay Close", "Koastie, DLG.", "assets/album-art1.jpg", Duration(minutes: 4, seconds: 20)),
    Song("Cheesin", "ARLØ", "assets/album-art2.jpg", Duration(minutes: 4, seconds: 69)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData.dark(),
      home: MusicPlayer(songs[1]),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  final Song song;

  const MusicPlayer(this.song);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  static const double BACKGROUND_BLUR = 50.0;

  @override
  Widget build(final BuildContext context) {
    final DecorationImage albumArt = DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage(widget.song.cover),
    );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: albumArt),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: BACKGROUND_BLUR, sigmaY: BACKGROUND_BLUR),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopRow(context),
                  buildSongContent(context, albumArt),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildSongContent(BuildContext context, DecorationImage albumArt) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildCoverArt(context, albumArt),
            const SizedSpacer(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfo(context),
                const SizedSpacer(height: 16),
                buildPlayTime(context),
              ],
            ),
            Expanded(child: buildControls(context)),
          ],
        ),
      ),
    );
  }

  Row buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [IconButton(onPressed: back, icon: Icon(CupertinoIcons.chevron_down)), Text("Playlist #1"), IconButton(onPressed: more, icon: Icon(CupertinoIcons.ellipsis))],
    );
  }

  Widget buildBackButton(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: InkWell(
        splashColor: Colors.yellow,
        highlightColor: Colors.green,
        focusColor: Colors.blue,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(.1),
          ),
          child: Icon(CupertinoIcons.chevron_down),
        ),
        onTap: back,
      ),
    ); // todo: how to contrast this color?
  }

  void back() => print("back");

  void more() => print("more");

  Widget buildCoverArt(BuildContext context, DecorationImage albumArt) {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: albumArt,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
    );
  }

  Widget buildPlayTime(final BuildContext context) {
    const Duration playTime = Duration(minutes: 1, seconds: 14);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Scrubber(position: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(asPlayTime(playTime), style: TextStyle(color: Colors.white.withOpacity(.8))),
            Text('-' + asPlayTime(widget.song.duration), style: TextStyle(color: Colors.white.withOpacity(.8))),
          ],
        ),
      ],
    );
  }

  String asPlayTime(final Duration duration, {final String separator = ':'}) {
    final NumberFormat seconds = NumberFormat("00");
    return "${duration.inMinutes}$separator${seconds.format(duration.inSeconds - (duration.inMinutes * 60))}";
  }

  Widget buildControls(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: previous, icon: Icon(CupertinoIcons.arrow_left_to_line, color: Colors.white, size: 24)),
        IconButton(onPressed: playPause, icon: Icon(CupertinoIcons.pause, color: Colors.white, size: 38)),
        IconButton(onPressed: next, icon: Icon(CupertinoIcons.arrow_right_to_line, color: Colors.white, size: 24)),
      ],
    );
  }

  Widget buildInfo(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.song.name, style: const TextStyle(color: Colors.white)),
            Text(widget.song.artist, style: const TextStyle(color: Colors.white)),
          ],
        ),
        IconButton(onPressed: favorite, icon: Icon(CupertinoIcons.heart, color: Colors.white))
      ],
    );
  }

  void previous() {}

  void playPause() {}

  void next() {}

  void favorite() {}
}
