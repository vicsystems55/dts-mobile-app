import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fmfdts/screens/SubmissionScreen.dart';
import 'package:http/http.dart' as http;

class Submission {

  TextEditingController emailController = TextEditingController();

  

    Future<dynamic> register() async {


    String url = "https://dtsapi.icreateagency.com/api/register";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          // 'name': nameController.text,
          'email': emailController.text,
          // 'password': passwordController.text
        }),
      );
      if (response.statusCode == 200) {
        // Successful response
        var _jsonDecode = jsonDecode(response.body);
        print(_jsonDecode);
        // await putData(_jsonDecode);

        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SubmissionsScreen()),
        // );

        // ignore: use_build_context_synchronously
      } else {
        // Backend returned an error

        var errorMessage = jsonDecode(response.body)[
            'errors']; // Modify this based on the actual error field in the response
        print(errorMessage['name']);

        resolveError(error) {
          String name_error = '';
          String email_error = '';
          String password_error = '';

          if (error['name'] != null) {
            name_error = error['name'][0];
          }
          if (error['email'] != null) {
            email_error = error['email'][0];
          }
          if (error['password'] != null) {
            password_error = error['password'][0];
          }

          return name_error + '\n' + email_error + '\n' + password_error;
        }

   

        // TODO: Handle the error, e.g., show a snackbar or an error dialog.
      }
    } catch (SocketException) {


      print(SocketException);
    }

    return Future.value(true);
  }
}