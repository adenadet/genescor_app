import 'package:flutter/material.dart';
import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/appointment.dart';
import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/auth/register.dart';
import 'package:genescor/presentation/screens/home.dart';

class AppointmentLoading extends StatefulWidget {
  Appointment? appointment;

  AppointmentLoading({
    this.appointment,
  });
  @override
  _AppointmentLoadingState createState() => _AppointmentLoadingState();
}

class _AppointmentLoadingState extends State<AppointmentLoading> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = true;

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else if (response.error == 'unauthorized') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else if (response.error == 'Unauthenticated.') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    //_loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (val) => val!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('Email')),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              //keyboardType: TextInputType.emailAddress,
              controller: txtPassword,
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Invalid Email Address' : null,
              decoration: kInputDecoration('password')),
          SizedBox(
            height: 20,
          ),
          kTextButton('Login', () {
            if (formKey.currentState!.validate()) {
              setState(() {
                loading = true;
                //_loginUser();
              });
            }
          }, null),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
