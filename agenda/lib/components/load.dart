import 'package:flutter/material.dart';

load() {
  return Align(
    alignment: Alignment.topCenter,
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.indigoAccent),
    ),
  );
}
