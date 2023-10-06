import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:redditech/snake/game/GameChoice.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  final int speed;
  final String levelName;
  const Game({Key? key, required this.speed, required this.levelName})
      : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 700;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(620);
  void generateNewFood() {
    food = randomNumber.nextInt(620);
    noFoodInsideSnake(food);
  }

  noFoodInsideSnake(int s) {
    for (int i = 0; i < snakePosition.length; i++) {
      if (snakePosition[i] != s) {
        return generateNewFood();
      }
    }
  }

  void startGame() {
    snakePosition = [45, 65, 85, 105, 125];
    final duration = Duration(milliseconds: widget.speed);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(
      () {
        switch (direction) {
          case ('down'):
            if (snakePosition.last > 680) {
              snakePosition.add(snakePosition.last + 20 - 700);
            } else {
              snakePosition.add(snakePosition.last + 20);
            }
            break;

          case ('up'):
            if (snakePosition.last < 20) {
              snakePosition.add(snakePosition.last - 20 + 700);
            } else {
              snakePosition.add(snakePosition.last - 20);
            }

            break;
          case ('left'):
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last - 1 + 20);
            } else {
              snakePosition.add(snakePosition.last - 1);
            }
            break;

          case ('right'):
            if ((snakePosition.last + 1) % 20 == 0) {
              snakePosition.add(snakePosition.last + 1 - 20);
            } else {
              snakePosition.add(snakePosition.last + 1);
            }
            break;

          default:
        }

        if (snakePosition.last == food) {
          generateNewFood();
        } else {
          snakePosition.removeAt(0);
        }
      },
    );
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; i < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Perdu !', style: GoogleFonts.lato()),
          content: Text(
            'Votre score est de ' +
                (snakePosition.length - 5).toString() +
                ' points',
            style: GoogleFonts.lato(),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const GameStage(),
                      ),
                    );
                  },
                  child: Text('Accueil', style: GoogleFonts.lato()),
                ),
                TextButton(
                  onPressed: () {
                    startGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('Rejouer ?', style: GoogleFonts.lato()),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 90, 139),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const GameStage(),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "score : " + (snakePosition.length - 5).toString(),
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            Text(
              widget.levelName,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 123, 182, 231),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20),
                itemBuilder: (BuildContext context, int index) {
                  if (snakePosition.contains(index)) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: const Color.fromARGB(255, 13, 235, 13),
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == food) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: const Color.fromARGB(167, 13, 235, 13),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: const Color.fromARGB(255, 123, 182, 231),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 30, 90, 139),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 5.0, left: 20.0, right: 20.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: startGame,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 20, right: 20, bottom: 5),
                        child: Text(
                          'l a n c e r',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 30, 90, 139),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
