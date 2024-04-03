import 'package:audioplayers/audioplayers.dart';
import 'package:birthday_card_flame/title_page.dart';
import 'package:flutter/material.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'first_page.dart';

void main() {
  runApp(BirthdayCardApp());
}

class BirthdayCardApp extends StatefulWidget {
  BirthdayCardApp({super.key});

  @override
  State<BirthdayCardApp> createState() => _BirthdayCardAppState();
}

class _BirthdayCardAppState extends State<BirthdayCardApp> with WidgetsBindingObserver {
  final GlobalKey _frontKey = GlobalKey<FrontPageState>();
  final GlobalKey _backwardKey = GlobalKey<BackwardPageState>();

  late final _frontPage = RepaintBoundary(key: _frontKey, child: FrontPage());
  late final _backwardPage = BackwardPage(key: _backwardKey,);

  final player = AudioPlayer();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      player.resume();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    player.play(AssetSource("music/audio.mp3"));
    player.onPlayerComplete.listen((event) {
      player.play(AssetSource("music/audio.mp3"));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageFlipBuilder(
          frontBuilder: (_) => _frontPage,
          backBuilder: (_) => _backwardPage,
        ),
      ),
    );
  }
}
