import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Color representation shown correctly", (){
    String c = Colors.red.withOpacity(0.6).value.toRadixString(16);
    String c3 = Colors.red.withOpacity(0.6).value.toRadixString(32);
    String c2 = Colors.red.withOpacity(0.6).value.toString();
    String c4 = Colors.red.withOpacity(0.6).toString();

    stderr.writeln('radixString(16): ' + c);
    stderr.writeln('radixString(32): ' + c3);
    stderr.writeln('value.tostring(): ' + c2);
    stderr.writeln('tostring: ' + c4);
    expect(1, 1);
  });

  test("icon string representation check", (){
    
      stderr.writeln(Icons.home.toString());
      stderr.writeln(Icons.home.codePoint);
      
  });
}