import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const storage = FlutterSecureStorage();

  Future<void> loginUser(
    String? email,
    String? password,
    BuildContext context
  ) async {

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

     // Convert JSON response into Dart map
    final data = jsonDecode(response.body);

    // Save JWT token 
    await storage.write(key: 'jwt', value: data['token'],);

    print(data['message']);

    if (data['token'] != null){
      Navigator.pushNamed(context, '/addMatchDetails');

    }
}