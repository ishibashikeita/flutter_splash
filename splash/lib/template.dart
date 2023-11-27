import 'package:flutter/material.dart';
import 'package:splash/main.dart';
import 'dart:ui';
import 'firebase.dart';
import 'gamePage.dart';

class template extends StatefulWidget {
  template({super.key});

  @override
  State<template> createState() => _templateState();
}

class _templateState extends State<template> {
  late Future _data;
  final service = FirestoreService();

  foreach(List name) {
    String tmpName = '';
    name.forEach((element) {
      tmpName += element.toString() + ',';
    });
    return tmpName;
  }

  @override
  void initState() {
    _data = service.getTemplate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('テンプレートを選択'),
          backgroundColor: Colors.lightBlue.withOpacity(0.3),
        ),
        body: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/kusa.jpg'),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('選択してスタート！！'),
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List names = snapshot.data;

                        return Flexible(
                          child: ListView.builder(
                            itemCount: names.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return gamepage(
                                            names: names[index],
                                          );
                                        },
                                      ),
                                    );
                                    print(names[index]);
                                  },
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                          child: FractionallySizedBox(
                                            widthFactor: 0.45,
                                            heightFactor: 0.9,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                child: FittedBox(
                                                  child: Icon(Icons.group),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  width: size.width * 0.5,
                                                  height: size.height * 0.05,
                                                  child: Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.fitWidth,
                                                      child: Text(
                                                        foreach(names[index]),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  width: size.width * 0.5,
                                                  height: size.height * 0.02,
                                                  child: Center(
                                                      child: Text(
                                                    names[index]
                                                            .length
                                                            .toString() +
                                                        '人',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        Container(
                                          width: size.height * 0.05,
                                          height: size.height * 0.05,
                                          child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 50,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    service
                                                        .delete(names[index]);
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return MyApp();
                                                        },
                                                      ),
                                                    );
                                                  });
                                                },
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      } else {
                        return Text('error');
                      }
                    })
              ],
            ),
          ],
        ));
  }
}
