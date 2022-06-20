import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/user.dart';

import 'package:genescor/presentation/screens/home.dart';
import 'package:genescor/presentation/screens/dashboard/patient.dart';
import 'package:genescor/presentation/screens/auth/register.dart';
import 'package:genescor/presentation/screens/auth/reset.dart';

import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/utils/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  late String email, password;
  bool _validatePass = false;
  bool _validateEmail = false;
  String errorMessage = "";
  bool _passwordVisible = false;
  final passwordController = TextEditingController();

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    //print(response.error);
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.cyan.shade700,
          Colors.cyan.shade300,
          Colors.cyanAccent
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Image.asset("assets/images/sign-in.png",
                width: double.infinity, height: 200),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text("Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 1,
                      ),
                      Center(
                        child: Text(
                          Constants.textSmallSignIn,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      //Text("Register", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  //Image.asset("assets/images/sign.png",width: 120,height: 100),
                ],
              ),
            ),
            const SizedBox(height: 13),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 25,
                          offset: Offset(0, 10))
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 25,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        child: TextField(
                                          controller: txtEmail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.mail),
                                            hintText: "Enter your mail ID",
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              email = value.trim();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !_validateEmail
                                    ? Container()
                                    : Text(
                                        errorMessage,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Text("    Password",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: [BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 25,
                                    //     offset: Offset(0, 2)
                                    // )]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: txtPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: !_passwordVisible,
                                          //This will obscure text dynamically
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock),
                                            hintText: 'Enter your password',
                                            hintStyle: const TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black45,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !_validatePass
                                    ? Container()
                                    : Text(
                                        errorMessage,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    password = passwordController.text;
                                    print('Working');
                                    _loginUser();
                                    //_signin(email, password);
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 75),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.cyan.shade500,
                                        border:
                                            Border.all(color: Colors.black12),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 4)
                                        ]),
                                    child: const Center(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Forgot Password?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetScreen()));
                                },
                                child: Text("To Reset Click Here!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.cyan.shade500,
                                    )),
                              )
                            ]),
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("Don't have an account?"),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Text("Register now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.cyan.shade500,
                                    )),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
