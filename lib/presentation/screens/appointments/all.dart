import 'package:flutter/material.dart';

import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/appointment.dart';

import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/logic/services/appointment_service.dart';
import 'package:genescor/logic/services/post_service.dart';
import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/screens/auth/login.dart';
import 'package:genescor/presentation/screens/appointments/form.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<dynamic> appointmentList = [];
  int userId = 0;
  bool _loading = true;

  /* void handleDeletePost(int id) async {
    ApiResponse response = await deletePost(id);

    if (response.error == null) {
      retrieveAppointments();
    } else if ((response.error == 'Unauthorized') ||
        (response.error == 'Unauthenticated.')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  } */

/*   void handlePostLike(int? id) async {
    ApiResponse response = await likeUnlikePost(id);

    if (response.error == null) {
      retrieveAppointments();
    } else if ((response.error == 'Unauthorized') ||
        (response.error == 'Unauthenticated.')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  } */

  Future<void> retrieveAppointments() async {
    userId = await getUserId();
    ApiResponse response = await getAppointments();

    if (response.error == null) {
      setState(() {
        appointmentList = response.data as List<dynamic>;
        _loading = false;
      });
    } else if (response.error == 'unauthorized') {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    retrieveAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () {
            return retrieveAppointments();
          },
          child: ListView.builder(
              itemCount: appointmentList.length,
              itemBuilder: (BuildContext context, int index) {
                Appointment appointment = appointmentList[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () {},
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                            image: appointment.patient!.image !=
                                                    null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        '$profileImageURL/${appointment.patient!.image}'))
                                                : DecorationImage(
                                                    image: NetworkImage(
                                                        '$profileImageURL/default.png')),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${appointment.patient!.firstName} ${appointment.patient!.lastName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      )
                                    ]),
                                  ),
                                  appointment.patient!.id == userId
                                      ? PopupMenuButton(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              )),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                child: Text('Edit'),
                                                value: 'edit'),
                                            PopupMenuItem(
                                                child: Text('Delete'),
                                                value: 'delete'),
                                          ],
                                          onSelected: (val) {},
                                        )
                                      : SizedBox(),
                                ]),
                            Text('${appointment.complaint}'),
                            ButtonBar(),
                          ])),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppointmentForm(
                    title: 'New Post',
                  )));
        },
        child: Icon(Icons.video_call),
      ),
    );
    /*_loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return retrieveAppointments();
            },R
            child: ListView.builder(
                itemCount: appointmentList.length,
                itemBuilder: (BuildContext context, int index) {
                  Appointment appointment = appointmentList[index];
                  return Scaffold(
                    body: Text('${appointment.complaint}'),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AppointmentForm(
                                  title: 'New Post',
                                )));
                      },
                      child: Icon(Icons.add),
                    ),
                  );
                }));*/
  }
}
