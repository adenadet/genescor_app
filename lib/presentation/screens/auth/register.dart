import 'package:flutter/material.dart';
import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/user.dart';

import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/home.dart';
import 'package:genescor/logic/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(txtFirstName.text, txtLastName.text,
        txtEmail.text, txtPassword.text, txtConfirmPassword.text);
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Successful')));
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtFirstName,
                validator: (val) => val!.isEmpty ? 'Invalid First Name' : null,
                decoration: kInputDecoration('First Name')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtLastName,
                validator: (val) => val!.isEmpty ? 'Invalid Last Name' : null,
                decoration: kInputDecoration('Last Name / Surname')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (val) => val!.isEmpty ? 'Invalid Email' : null,
                decoration: kInputDecoration('Email')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                //keyboardType: TextInputType.emailAddress,
                controller: txtPassword,
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Invalid Password' : null,
                decoration: kInputDecoration('Password')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                //keyboardType: TextInputType.emailAddress,
                controller: txtConfirmPassword,
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Invalid Password' : null,
                decoration: kInputDecoration('Confirm Password')),
            SizedBox(
              height: 20,
            ),
            kTextButton('Register', () {
              if (formkey.currentState!.validate()) {
                setState(() {
                  loading = true;
                  _registerUser();
                });
              }
            }, null),
            SizedBox(height: 10),
            kLoginRegisterHint('Already have an account ', 'Login Here', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }),
          ],
        ),
      ),
    );
  }
}
