import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

//import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:http/http.dart' as http;
//import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:image_picker/image_picker.dart';

import 'package:genescor/logic/declarations/constant.dart';

import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/doctor_speciality.dart';
import 'package:genescor/data/models/appointment.dart';

//import 'package:genescor/screens/pages/home.dart';
import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/appointments/loading.dart';

import 'package:genescor/logic/services/appointment_service.dart';
import 'package:genescor/logic/services/doctor_service.dart';
import 'package:genescor/logic/services/post_service.dart';
import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/widgets/multi_select.dart';

class AppointmentForm extends StatefulWidget {
  final Appointment? appointment;
  final String? title;

  AppointmentForm({
    this.appointment,
    this.title,
  });

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtComplaint = TextEditingController();

  List<dynamic>? complaint;
  late String complaintResult;
  String complaintType = '';
  String? consultantType;
  String? consultantTypeId;
  int userId = 0;

  List<dynamic> specialities = [];
  String? specialityId;

  Future<String> getSpecialities() async {
    String token = await getToken();
    var res = await http.get(Uri.parse(doctorSpecialityURL), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });
    var resBody = jsonDecode(res.body);
    setState(() {
      specialities = resBody['specialities'];
    });

    return "true";
  }

  void createNewAppointment() async {
    ApiResponse response = await createAppointment(
        int.parse(consultantTypeId.toString()),
        txtComplaint.text,
        complaint ?? []);
    if (response.error == null) {
      //Navigator.of(context).pop();
      //Appointment appointment = response.data!['appointment'];
      print(Appointment);
      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      //Find error here, change to namedroute}), (route) => false);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AppointmentLoading()),
          (route) => false);
      //.push(MaterialPageRoute(builder: (context) => Home()));
    } else if ((response.error == 'Unauthenticated.') ||
        (response.error == 'unauthorized')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.appointment != null) {
      txtComplaint.text = widget.appointment!.complaint ?? '';
    }
    complaint = [];
    complaintResult = '';
    getSpecialities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            DropdownButton(
                hint: Text("Choose Your Doctor"),
                value: consultantTypeId,
                items: specialities.map((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: Text(item['name']),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    consultantTypeId = newVal.toString();
                    print(consultantTypeId);
                  });
                }),
            SizedBox(
              height: 20,
            ),
            MultiSelectFormField(
              autovalidate: AutovalidateMode.disabled,
              chipBackGroundColor: Colors.blue,
              chipLabelStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              checkBoxActiveColor: Colors.blue,
              checkBoxCheckColor: Colors.white,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "Symptoms",
                style: TextStyle(fontSize: 16),
              ),
              validator: (value) {
                if (value == null || value.length == 0) {
                  return 'Please select one or more options';
                }
                return null;
              },
              dataSource: [
                {
                  "display": "Fever",
                  "value": "1",
                },
                {
                  "display": "Chest Pain",
                  "value": "2",
                },
                {
                  "display": "Loss of Breathe",
                  "value": "3",
                },
                {
                  "display": "Body Pain",
                  "value": "4",
                },
                {
                  "display": "Swelling of Limbs",
                  "value": "5",
                },
                {
                  "display": "Vision impendiment",
                  "value": "6",
                },
                {
                  "display": "Violent Shaking",
                  "value": "7",
                },
              ],
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text('Please choose one or more'),
              initialValue: complaint,
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  complaint = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtComplaint,
                maxLines: 9,
                validator: (val) => val!.isEmpty ? 'Content required...' : null,
                decoration: InputDecoration(
                  labelText: "Complaint",
                  hintText: "Explain your complaint",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black38)),
                )),
            SizedBox(
              height: 20,
            ),
            kTextButton('Create Appointment', () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                  //print(complaint);
                  createNewAppointment();
                });
              }
            }, null),
          ],
        ),
      ),
    );
  }
}


//This is to write watever you want as you please. This can take as much information as you like to put in. However, we only want those with a certain level of access to create a new blog