import 'dart:math';
import 'package:shake/shake.dart';
import 'package:flutter/material.dart';
import 'package:splash/resultPage.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'firebase.dart';

class gamepage extends StatefulWidget {
  gamepage({super.key, required this.names});

  List names;
  @override
  State<gamepage> createState() => _gamepageState();
}

class _gamepageState extends State<gamepage> {
  int count = 0;
  bool fin = false;
  int change = 0;
  int limit = Random().nextInt(40 - 3 + 1) + 3;
  int item = 0;
  bool shakeSound = Random().nextBool();
  final Map<String, int> result = {};
  final audioPlayer = AudioPlayer();
  @override
  void initState() {
    widget.names.forEach((element) {
      result[element] = 0;
    });
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        shake();
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void namesChange() {
    setState(() {
      item = Random().nextInt(6 - 1 + 1) + 1;
      change = 0;
      widget.names.add(widget.names[0]);
      widget.names.remove(widget.names[0]);
    });
  }

  void shake() {
    setState(() {
      bool shakeSound = Random().nextBool();
      if (fin == false) {
        if (shakeSound) {
          audioPlayer.play(AssetSource("shake1.mp3"));
          audioPlayer.stop();
        } else {
          audioPlayer.play(AssetSource("shake2.mp3"));
          audioPlayer.stop();
        }

        HapticFeedback.heavyImpact();
        count++;
        change++;
        result[widget.names[0]] = result[widget.names[0]]! + 1;

        if (count == limit) {
          fin = !fin;
          HapticFeedback.vibrate();
          audioPlayer.play(AssetSource("splash.mp3"));
          audioPlayer.stop();
        }
      }
    });
  }

  void helper() {
    setState(() {
      if (count < 5) {
        count = 0;
      } else {
        count = count - 5;
      }
      item = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print('limit: ' + limit.toString());
    print('names: ' + widget.names.toString());
    print('fin: ' + fin.toString());
    print('change: ' + change.toString());
    print('map: ' + result.toString());
    print('item: ' + item.toString());
    print('count: ' + count.toString());

    final service = FirestoreService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.withOpacity(0.3),
          toolbarHeight: size.height * 0.01,
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 1.0,
                    height: size.height * 0.1,
                    color: Colors.lightBlue.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            heightFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  widget.names[0].toString() + 'のターン',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.08),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 1.0,
                    height: size.height * 0.8266,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/kusa.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.95,
                      child: Center(
                        child: Container(
                          decoration: fin
                              ? BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/boom.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              : BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/cola.png'),
                                  ),
                                ),
                          // child: Container(
                          //   width: 100,
                          //   height: 100,
                          //   color: Colors.red,
                          // ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: fin
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return resultPage(
                                  temp: widget.names,
                                  loser: widget.names[0].toString(),
                                  result: result,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: size.width * 0.6,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'リザルトへ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.1),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (change > 2) {
                            audioPlayer.play(AssetSource("change.mp3"));
                            audioPlayer.stop();
                            namesChange();
                            print(widget.names);
                          } else {
                            audioPlayer.play(AssetSource("error.mp3"));
                            audioPlayer.stop();
                          }
                        },
                        child: Container(
                          width: size.width * 0.6,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              '交代',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.1),
                            ),
                          ),
                        ),
                      ),
              ),
              Align(
                alignment: Alignment(0.8, -0.7),
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      count.toString() + '回!!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment(0, 0),
              //   child: ElevatedButton(
              //       onPressed: () {
              //         shake();
              //       },
              //       child: Text('+')),
              // ),
              (fin == false && item == 1)
                  ? Align(
                      alignment: Alignment(-0.7, -0.6),
                      child: GestureDetector(
                        onTap: () {
                          audioPlayer.play(AssetSource("reverse.mp3"));
                          audioPlayer.stop();
                          change + 3;
                          namesChange();
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: ShaderMask(
                                child: Text(
                                  '無敵',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                shaderCallback: (Rect rect) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.orange,
                                      Colors.yellow,
                                      Colors.green,
                                      Colors.blue,
                                      Colors.blueGrey,
                                      Colors.purpleAccent,
                                    ],
                                  ).createShader(rect);
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/tate.png'),
                            ),
                          ),
                        ),
                      ))
                  : (fin == false && item == 5)
                      ? Align(
                          alignment: Alignment(-0.7, -0.6),
                          child: GestureDetector(
                            onTap: () {
                              audioPlayer.play(AssetSource("decount.mp3"));
                              audioPlayer.stop();
                              helper();
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      '回復できるよ?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/kaihuku.png'),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
            ],
          ),
        ));
  }
}
