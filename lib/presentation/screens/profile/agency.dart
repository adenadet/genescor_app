import 'package:flutter/material.dart';

class Agency extends StatefulWidget {
  @override
  _AgencyState createState() => _AgencyState();
}

class _AgencyState extends State<Agency> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'For NGOs only,\n you wll be able to invite your collleagues and you can all monitor your post of the agency',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
