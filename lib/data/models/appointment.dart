import 'package:genescor/data/models/user.dart';

class Appointment {
  int? id;
  User? patient;
  User? doctor;
  int? status;
  int? complaintType;
  String? complaint;
  int? doctorType;

  Appointment(
      {this.id,
      this.patient,
      this.doctor,
      this.status,
      this.complaintType,
      this.complaint,
      this.doctorType});

  //function to convert json data to user model
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patient: User(
        id: json['patient']['id'],
        firstName: json['patient']['first_name'],
        lastName: json['patient']['last_name'],
        image: json['patient']['image'],
        email: json['patient']['email'],
        userType: json['patient']['user_type'],
      ),
      /*doctor: User(
        id: json['doctor']['id'],
        firstName: json['doctor']['first_name'],
        lastName: json['doctor']['last_name'],
        image: json['doctor']['image'],
        email: json['doctor']['email'],
        userType: json['patient']['user_type'],
      ),*/
      status: json['status'],
      complaint: json['complaint'],
      complaintType: json['complaint_type'],
      doctorType: json['doctor_type'],
    );
  }
}
