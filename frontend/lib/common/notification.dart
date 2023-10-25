import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void alert(BuildContext context, String content) {
  Flushbar(
    message: content,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    messageColor: Colors.black87,
    backgroundColor: Color(0xFFFDE8EA),
    shouldIconPulse: false,
    icon: const Icon(Icons.info,size: 20,color: Colors.red,),
    borderRadius: BorderRadius.circular(4),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(milliseconds: 1500),
  ).show(context);
}
