import 'dart:async';

import 'package:birthday_card_flame/title_page.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'package:provider/provider.dart';
import 'first_page.dart';

void main() {
  runApp(BirthdayCardApp());
}

class BirthdayCardApp extends StatelessWidget {
  BirthdayCardApp({super.key});

  final GlobalKey _frontKey = GlobalKey<FrontPageState>();
  final GlobalKey _backwardKey = GlobalKey<BackwardPageState>();


  late final _frontPage = RepaintBoundary(key: _frontKey, child: FrontPage());
  late final _backwardPage = BackwardPage(key: _backwardKey,);
  // TODO: Use provider
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
