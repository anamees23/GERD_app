import 'databases.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

ph_data new_pH1 = new ph_data(0.00, DateTime.now());
void main() {
  print(new_pH1);
  new_pH1.insert_ph_data(new_pH1);
  print('done');
}
