import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//contains methods regarding interaction with the server's authentication services

final storage = const FlutterSecureStorage();

  Future<void> loginUser(String? email, String? password, BuildContext context) async {

    final response = await http.post(

        Uri.parse('http://localhost:3000/auth/login'),

        headers: {
            'Content-Type': 'application/json',
        },

        body: jsonEncode({
            'email': email,
            'password': password,
        }),
    );

    getToken(response, context);

     
}

Future<void> createUser(String? firstName, String? lastName, String? email, String? password, BuildContext context) async {
    final response = await http.post(
        Uri.parse('http://localhost:3000/auth/register'), 

        headers: {
            'Content-Type': 'application/json',
        },

        body: jsonEncode({
            'firstName': firstName, 
            'lastName': lastName, 
            'email': email, 
            'password': password
        }), 
    );

    getToken(response, context);

}

//when user logs in or creates a new account, get their token
void getToken(final response, BuildContext context) async {

    // Convert JSON response into Dart map
    final data = jsonDecode(response.body);

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Save JWT token 
    await storage.write(key: 'jwt', value: data['token'],);

    //show message of success or failure from server
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(data['message']), 
      duration: const Duration(seconds: 2),
      showCloseIcon: true
      ),);

    if (data['token'] != null){
      Navigator.pushNamed(context, '/addMatchDetails');
    }

}