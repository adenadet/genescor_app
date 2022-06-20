import 'package:flutter/material.dart';

class MedicalProfile extends StatefulWidget {
  @override
  _MedicalProfileState createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Medical Profile for Doctors only'),
      ),
    );
  }
}
