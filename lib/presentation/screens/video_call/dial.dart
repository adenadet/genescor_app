import 'package:flutter/material.dart';
import 'package:genescor/presentation/declare.dart';
import 'package:genescor/presentation/size_config.dart';
import 'body.dart';

class DialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgoundColor,
      body: Body(),
    );
  }
}
