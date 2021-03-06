// ignore_for_file: unused_import

import 'dart:io';
import 'package:antrian_rs/cari.dart';
import './daftar.dart';
import './tiket.dart';
import './homepage.dart';
import './pasienbaru.dart';
import './pasienlama.dart';
import './poliklinik.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
