import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Points extends HiveObject {
  final int points;
  final double moneyValue;

  Points({
    @required this.points,
    @required this.moneyValue,
  });
}
