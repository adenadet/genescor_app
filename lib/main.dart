import 'package:flutter/material.dart';
import 'package:genescor/presentation/screens/loading.dart';

void main() {
  runApp(GenescorApp());
}

class GenescorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
