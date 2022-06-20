import 'package:flutter/material.dart';

import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/profile/agency.dart';
import 'package:genescor/presentation/screens/profile/biodata.dart';
import 'package:genescor/presentation/screens/profile/medical.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Genescor'), centerTitle: true, actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false)
                });
          },
        )
      ]),
      body: currentIndex == 0
          ? BioData()
          : (currentIndex == 1 ? MedicalProfile() : Agency()),
      bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: '', tooltip: 'Bio Data'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mediation_outlined),
                    label: '',
                    tooltip: 'Medical'),
                //BottomNavigationBarItem(
                //icon: Icon(Icons.comment), label: '', tooltip: 'Stories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.work), label: '', tooltip: 'Agency'),
              ],
              currentIndex: currentIndex,
              onTap: (val) {
                setState(() {
                  currentIndex = val;
                });
              })),
    );
  }
}
