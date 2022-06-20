import 'dart:convert';
// import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Login
import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/appointment.dart';
//import 'package:genescor/models/user.dart';
import 'package:genescor/logic/services/user_service.dart';

//Create New Appointment
Future<ApiResponse> createAppointment(
  int consultantTypeId,
  String complaint,
  List<dynamic> complaintType,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.post(
      Uri.parse(appointmentsURL),
      body: jsonEncode({
        "consultant_type_id": consultantTypeId,
        "complaint": complaint,
        "complaint_type_id": complaintType,
      }),
      headers: {
        "Content-type": "application/json",
        "Accept": "applicaton/json",
        "Authorization": "Bearer $token"
      },
    );

    switch (response.statusCode) {
      case 200:
        print(jsonDecode(response.body));

        //apiResponse.error = null;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 500:
        apiResponse.error = serverAPIError;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

//Delete Appointment

//Get All Appointments
Future<ApiResponse> getAppointments() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(appointmentsURL), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['appointments']['data']
            .map((p) => Appointment.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getSymptoms() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(appointmentsURL), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['appointments']['data']
            .map((p) => Appointment.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
