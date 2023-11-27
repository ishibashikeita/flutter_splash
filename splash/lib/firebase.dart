import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> creat(names) async {
    await db.collection('template').add({
      'names': names,
    });
  }

  Future getTemplate() async {
    List data = [];
    final sn =
        await db.collection('template').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        data.add(element.get('names'));
      });
    });
    //print(data);
    return data;
  }

  Future delete(list) async {
    db.collection('template').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        /// usersコレクションのドキュメントIDを取得する
        //print(doc.id);
        /// 取得したドキュメントIDのフィールド値nameの値を取得する
        //print(doc.get('name'));

        if (listEquals(doc.get('names'), list)) {
          db.collection('template').doc(doc.id).delete();
        }
        ;
      });
    });
  }
}
