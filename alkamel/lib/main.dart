import 'package:alkamel/app.dart';
import 'package:alkamel/init_services.dart';
import 'package:flutter/material.dart';

void main() async {
  await initServices();
  runApp(const AlkamelApp());
}
