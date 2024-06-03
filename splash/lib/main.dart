import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:splash/firebase.dart';
import 'package:splash/template.dart';
import 'select.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(
      () async {
        await FirestoreService().onSignInWithAnonymousUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Container(
            width: size.width * 1.0,
            height: size.height * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  child: FittedBox(
                    child: BorderedText(
                      child: Text(
                        'Splash!!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                      ),
                      strokeWidth: 10.0,
                      strokeColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
              ),
              Center(
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  child: FittedBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          audioPlayer.play(AssetSource("button.mp3"));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return select();
                              },
                            ),
                          );
                        },
                        child: Text(
                          '新しく始める',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  child: FittedBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          audioPlayer.play(AssetSource("button.mp3"));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return template();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'テンプレートから始める',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
