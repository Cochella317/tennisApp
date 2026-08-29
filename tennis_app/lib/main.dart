import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tennis_app/Pages/homePage.dart';
import 'package:tennis_app/Pages/registrationPage.dart';
import 'package:tennis_app/Pages/signInPage.dart';
import 'Pages/addMatchDetails.dart';


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
        'homePage': (context) => const HomePage(title: '',),
        '/signInPage': (context) => const SignInPage(title: '',),
        '/addMatchDetails': (context) => const AddMatchDetails(title: ''),
        '/registrationPage': (context) => const registrationPage(title: ''),
        }
    );
  }
}

