import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bos Deneme123'),
      ),
      body: AnaEkranState(),
    );
  }
}

class AnaEkranState extends StatefulWidget {
  const AnaEkranState({Key? key}) : super(key: key);

  @override
  State<AnaEkranState> createState() => _AnaEkranStateState();
}

class _AnaEkranStateState extends State<AnaEkranState> {


  @override
  Widget build(BuildContext context) {
    return Center(

    );
  }
}


