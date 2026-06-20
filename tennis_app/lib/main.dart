import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/Pages/signInPage.dart';
import 'Pages/addMatchDetails.dart';
import 'package:http/http.dart' as http;


void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tennis App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 226, 226, 226)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInPage(title: '',), //change this
        '/signInPage': (context) => const SignInPage(title: '',),
        '/addMatchDetails': (context) => const AddMatchDetails(title: ''),
        }
    );
  }
}

