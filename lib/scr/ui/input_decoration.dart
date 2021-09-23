import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    @required String labelText,
  }) {
    return InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white54));
  }
}
