import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redditech/snake/game/GamePage.dart';

class GameStage extends StatelessWidget {
  const GameStage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 90, 139),
        centerTitle: true,
        title: Text('Bonus Redditech',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        leading: const Icon(FontAwesomeIcons.gamepad),
      ),
      backgroundColor: const Color.fromARGB(255, 30, 90, 139),
      body: Column(
        children: [
          Container(
            height: _height * 0.6,
            color: Colors.grey[900],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Difficulté :',
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                _level(context, 200, "Facile"),
                _level(context, 100, "Normal"),
                _level(context, 50, "Difficile"),
              ],
            ),
          )
        ],
      ),
    );
  }

  _level(BuildContext context, int _speed, String levelName) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                Game(speed: _speed, levelName: levelName),
          ),
        );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            levelName,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: 5,
            ),
          ),
        ),
      ),
    );
  }
}
