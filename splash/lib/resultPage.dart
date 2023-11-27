import 'dart:collection';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:splash/main.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'firebase.dart';

class resultPage extends StatefulWidget {
  resultPage(
      {super.key,
      required this.result,
      required this.loser,
      required this.temp});

  final Map<String, int> result;
  final String loser;
  final List temp;
  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  final _controller = ConfettiController(duration: const Duration(seconds: 5));
  final audioPlayer = AudioPlayer();
  final service = FirestoreService();
  late bool add = false;
  List<dynamic> dbTemp = [];
  late Map<String, int> sort = SplayTreeMap.of(widget.result, (a, b) {
    int compare = widget.result[b]!.compareTo(widget.result[a]!);
    //compareが0なら1に置き換える。
    return compare == 0 ? 1 : compare;
  });

  addset() async {
    dbTemp = await service.getTemplate();
    dbTemp.forEach((element) {
      if (listEquals(element, widget.temp)) {
        add = true;
      }
    });
  }

  @override
  void initState() {
    _controller.play();
    audioPlayer.play(AssetSource("result.mp3"));
    audioPlayer.stop();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(add);
    addset();
    print(sort);
    final Size size = MediaQuery.of(context).size;
    final service = FirestoreService();

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/kusa.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.1,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '最終結果～!!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              child: FittedBox(
                                  child: Text(
                                '敗者 : ' + widget.loser + 'さん',
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                              )),
                              width: size.width * 0.8,
                              height: size.height * 0.1,
                            ),
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.height * 0.55,
                            child: ListView.builder(
                                itemCount: widget.result.length + 1,
                                itemBuilder: (context, index) {
                                  return (index == 0)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: FittedBox(
                                                child: Text(
                                              '振った回数',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            width: 100,
                                            height: 50,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: FractionallySizedBox(
                                                    widthFactor: 1.0,
                                                    heightFactor: 1.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: FittedBox(
                                                          child: Text('第' +
                                                              index.toString() +
                                                              '位'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: FractionallySizedBox(
                                                    widthFactor: 1.0,
                                                    heightFactor: 1.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: FittedBox(
                                                          child: Text(
                                                            sort.keys.elementAt(
                                                                index - 1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: FractionallySizedBox(
                                                    widthFactor: 1.0,
                                                    heightFactor: 1.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: FittedBox(
                                                          child: Text((sort
                                                                  .values
                                                                  .elementAt(
                                                                      index - 1)
                                                                  .toString()) +
                                                              '回'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            width: 100,
                                            height: 100,
                                          ),
                                        );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.9),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyApp();
                      },
                    ),
                  );
                },
                child: FittedBox(
                  child: Text(
                    'タイトルへ戻る',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: service.getTemplate(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List sn = snapshot.data;
                    sn.forEach((element) {
                      if (listEquals(element, widget.temp)) {
                        add = true;
                      }
                    });
                    if (!add) {
                      return Align(
                        alignment: Alignment(0.0, 0.8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              service.creat(widget.temp);
                            });
                          },
                          child: FittedBox(
                            child: Text(
                              'テンプレートを保存',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }),
            Align(
              alignment: Alignment(0, -1.0),
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: pi / 2, // 紙吹雪を出す方向(この場合画面上に向けて発射)
                emissionFrequency: 0.1, // 発射頻度(数が小さいほど紙と紙の間隔が狭くなる)
                minBlastForce: 5, // 紙吹雪の出る瞬間の5フレーム分の速度の最小
                maxBlastForce:
                    20, // 紙吹雪の出る瞬間の5フレーム分の速度の最大(数が大きほど紙吹雪は遠くに飛んでいきます。)
                numberOfParticles: 4, // 1秒あたりの紙の枚数
                gravity: 0.1, // 紙の落ちる速さ(0~1で0だとちょーゆっくり)
                colors: const <Color>[
                  // 紙吹雪の色指定
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
