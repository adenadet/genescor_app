import 'package:flutter/material.dart';
import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/screens/appointments/all.dart';
import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/blogs/post_screen.dart';
import 'package:genescor/presentation/screens/blogs/post_form.dart';
import 'package:genescor/presentation/screens/profile/profile.dart';
//import 'package:genescor/presentation/screens/pharmacy/pharmacy_screen.dart';
//import 'package:genescor/presentation/screens/pharmacy/product_screen.dart';
//import 'package:genescor/presentation/cubit/room/join_room_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Genescor'), centerTitle: true, actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
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
      body: currentIndex == 0 ? PostScreen() : Appointments(),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.comment), label: '', tooltip: 'Stories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medication),
                    label: '',
                    tooltip: 'Pharmacy'),
                //BottomNavigationBarItem(
                //icon: Icon(Icons.comment), label: '', tooltip: 'Stories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: '',
                    tooltip: 'Appointments'),
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
