import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> onSignInWithAnonymousUser() async {
    try {
      await firebaseAuth.signInAnonymously();
    } catch (e) {
      Fluttertoast.showToast(msg: '通信環境のいい場所で再起動してください');
    }
  }

  Future<void> creat(names) async {
    await db
        .collection('template')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('templateList')
        .add({
      'names': names,
    });
  }

  Future getTemplate() async {
    List data = [];
    final sn = await db
        .collection('template')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('templateList')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        data.add(element.get('names'));
      });
    });
    //print(data);
    return data;
  }

  Future delete(list) async {
    db
        .collection('template')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('templateList')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        /// usersコレクションのドキュメントIDを取得する
        //print(doc.id);
        /// 取得したドキュメントIDのフィールド値nameの値を取得する
        //print(doc.get('name'));

        if (listEquals(doc.get('names'), list)) {
          db
              .collection('template')
              .doc(firebaseAuth.currentUser!.uid)
              .collection('templateList')
              .doc(doc.id)
              .delete();
        }
        ;
      });
    });
  }
}
