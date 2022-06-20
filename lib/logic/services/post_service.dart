import 'dart:convert';
// import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
//  import 'package:shared_preferences/shared_preferences.dart';

import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/post.dart';

import 'package:genescor/logic/services/user_service.dart';

//create A Post
Future<ApiResponse> createPost(
    String content, String? image, int? categoryId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(postsURL),
      body: image != null
          ? jsonEncode({
              "category_id": categoryId,
              "content": content,
              "image": image,
            })
          : jsonEncode({
              "category_id": categoryId,
              "content": content,
            }),
      headers: {
        "Content-type": "application/json",
        "Accept": "applicaton/json",
        "Authorization": "Bearer $token"
      },
    );

    switch (response.statusCode) {
      case 200:
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
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Delete A Post
Future<ApiResponse> deletePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.delete(Uri.parse('$postsURL/$postId'), headers: {
      'Content-type': "application/json",
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 403:
        apiResponse.error = notFound;
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

//get All Posts
Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    //print(postsURL);
    final response = await http.get(Uri.parse(postsURL), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        print(jsonDecode(response.body)['blogs']);
        apiResponse.data = jsonDecode(response.body)['blogs']
            .map((p) => Post.fromJson(p))
            .toList();
        print(apiResponse.data);
        apiResponse.data as List<Post>;
        //print(apiResponse);
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

//Like A Post
Future<ApiResponse> likeUnlikePost(int? postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse('$postsURL/$postId/likes'), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 403:
        apiResponse.error = notFound;
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

//update A Post
Future<ApiResponse> updatePost(
    int postId, String content, int categoryId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$postsURL/$postId'), headers: {
      'Accept': 'applicaton/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['posts.data']
            .map((p) => Post.fromJson(p))
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
