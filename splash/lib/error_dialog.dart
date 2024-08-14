import 'package:flutter/material.dart';

class ErrorDialog {
  showErrorDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('通信エラー'),
            content: Text('通信エラーです。\n通信環境のいい場所で再起動してください。'),
          );
        });
  }
}
