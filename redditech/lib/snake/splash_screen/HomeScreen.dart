import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redditech/snake/game/GameChoice.dart';

class Bonus extends StatefulWidget {
  const Bonus({Key? key}) : super(key: key);

  @override
  State<Bonus> createState() => _BonusState();
}

class _BonusState extends State<Bonus> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 90, 139),
        centerTitle: true,
        title: Text('Bonus Redditech', style: GoogleFonts.lato()),
        leading: const Icon(FontAwesomeIcons.gamepad),
      ),
      backgroundColor: const Color.fromARGB(255, 30, 90, 139),
      body: TextLiquidFill(
        boxHeight: MediaQuery.of(context).size.height,
        text: 'Redditech bonus',
        waveColor: Colors.white,
        boxBackgroundColor: const Color.fromARGB(255, 30, 90, 139),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.lato(
          color: Colors.blue,
          fontSize: 80.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 6), (_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const GameStage(),
        ),
      );
    });
  }
}
