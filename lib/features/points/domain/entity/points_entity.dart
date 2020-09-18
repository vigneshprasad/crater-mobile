import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Points extends HiveObject {
  final int points;

  Points({
    @required this.points,
  });
}
