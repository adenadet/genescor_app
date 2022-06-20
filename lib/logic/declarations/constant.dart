import 'package:flutter/material.dart';

const baseDirectURL = 'https://testapp.genescor.com';
const baseURL = 'https://testapp.genescor.com/api';

const commentsURL = baseURL + '/login';
const twilioURL = 'http://twiliochatroomaccesstoken-4453.twil.io/accessToken';

const appointmentsURL = baseURL + '/emr/appointments';
const doctorSpecialityURL = baseURL + '/emr/doctor_specialities';
const loginURL = baseURL + '/login';
const logoutURL = baseURL + '/logout';
const postsURL = baseURL + '/blogs/posts';
const productsURL = baseURL + '/emr/products';
const profileImageURL = baseDirectURL + '/img/profile/';
const registerURL = baseURL + '/register';
const symptomsURL = baseURL + '/emr/symptoms';
const uploadedImageURL = baseDirectURL + '/img/profile/';
const userURL = baseURL + '/user';

// ----Errors ----
const serverAPIError = 'Server API Error';
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';
const notFound = 'Not Found';

// ---input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.black)),
  );
}

// -- button
TextButton kTextButton(String label, Function onPressed, Color? color) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => color ?? Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10, horizontal: 10))),
    onPressed: () => onPressed(),
  );
}

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text(text),
    GestureDetector(
      child: Text(label, style: TextStyle(color: Colors.blue)),
      onTap: () => onTap(),
    )
  ]);
}

// Like and Comment Button
Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: 4),
              Text('$value'),
            ],
          ),
        ),
      ),
    ),
  );
}
