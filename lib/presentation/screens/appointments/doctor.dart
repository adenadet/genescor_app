import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genescor/data/models/user.dart';
import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/logic/services/doctor_service.dart';

class DoctorProfileScreen extends StatefulWidget {
  final User? doctor;

  DoctorProfileScreen({
    this.doctor,
  });

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(children: [
            Center(child: CircularProgressIndicator()),
            Center(
              child: Text('Matching You with A Doctor'),
            )
          ])
        : Container(
            height: 230,
            child: Stack(
              children: [
                Positioned(
                    top: 35,
                    left: 30,
                    child: Material(
                        child: Container(
                            height: 180,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                              /*new BoxShadow[(
                          color: Colors.grey.withOpacity(.3),
                          offset: new Offset(-10, 10),
                          blurRadius: 20,
                          spreadRadius: 4)],
                        */
                            )))),
                Positioned(
                    top: 0,
                    left: 30,
                    child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      '$profileImageURL/default.png'))),
                        ))),
                Positioned(
                    top: 60,
                    left: 200,
                    child: Container(
                      height: 150,
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Dr. ${widget.doctor!.firstName} ${widget.doctor!.lastName}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF363f93),
                                  fontWeight: FontWeight.bold)),
                          Text("Sex: ${widget.doctor!.sex}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Divider(color: Colors.black),
                          Row(
                            children: [
                              kTextButton("Accept", () {}, Colors.green[800]),
                              kTextButton("Cancel", () {}, Colors.green[800]),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ));
  }
}
