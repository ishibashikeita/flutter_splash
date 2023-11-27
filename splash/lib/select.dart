import 'package:flutter/material.dart';
import 'package:splash/gamePage.dart';
import 'package:audioplayers/audioplayers.dart';

class select extends StatefulWidget {
  const select({super.key});

  @override
  State<select> createState() => _selectState();
}

class _selectState extends State<select> {
  int status = 2;
  var names = []..length = 2;
  final audioPlayer = AudioPlayer();

  _selectCount(value) {
    setState(() {
      // audioPlayer.play(AssetSource("button.mp3"));
      status = value;
      names..length = status;
    });
  }

  @override
  void initState() {
    audioPlayer.play(AssetSource("select.mp3"));
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ゲーム設定画面'),
        backgroundColor: Colors.lightBlue.withOpacity(0.3),
      ),
      body: Stack(children: [
        Container(
          width: size.width * 1.0,
          height: size.height * 1.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/kusa.jpg'),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  width: size.width * 1.0,
                  height: size.height * 0.05,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        '人数を選択してください。',
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  height: size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Radio(
                        value: 2,
                        groupValue: status,
                        onChanged: _selectCount,
                      ),
                      Radio(
                        value: 3,
                        groupValue: status,
                        onChanged: _selectCount,
                      ),
                      Radio(
                        value: 4,
                        groupValue: status,
                        onChanged: _selectCount,
                      ),
                      Radio(
                        value: 5,
                        groupValue: status,
                        onChanged: _selectCount,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                  width: size.width * 1.0,
                  child: Center(
                    child: Text(
                      status.toString() + '人でプレイする',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.2)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: status,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: size.width * 0.9,
                                height: size.height * 0.2,
                                //color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '名前' +
                                                '(' +
                                                (index + 1).toString() +
                                                '人目)',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: FractionallySizedBox(
                                        widthFactor: 0.9,
                                        heightFactor: 0.8,
                                        child: Container(
                                          child: SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: TextField(
                                              onChanged: (value) {
                                                names[index] = value;
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                iconColor: Colors.black,
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          //color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.7),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            onPressed: () {
              if (!names.contains(null)) {
                audioPlayer.play(AssetSource("button.mp3"));
                audioPlayer.stop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      List name = names;
                      return gamepage(
                        names: name,
                      );
                    },
                  ),
                );
              } else {}
            },
            child: Text('ゲームスタート'),
          ),
        )
      ]),
    );
  }
}
