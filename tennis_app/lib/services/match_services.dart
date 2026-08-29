import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tennis_app/models/match.dart'; 

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = const FlutterSecureStorage();

Future<String?> getToken() async{
    String? token = await secureStorage.read(key: 'jwt'); // Read token from storage 
    return token;  
}

Future<void> createMatch(Match match, BuildContext context) async {
    final token = await getToken();

    //send request
    final response = await http.post(

        Uri.parse('http://localhost:3000/match/addMatch'),

        headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token', 
            'Content-Type': 'application/json',
        },

        body: jsonEncode({
            'opponentFirstName': match.opponentFirstName,
            'opponentLastName': match.opponentLastName,
            'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(match.date), 
            'matchType': match.matchType, 
            'score': match.score,
            'win': match.winOrLoss, 
            'surface': match.surface, 
            'firstServePercentage': match.firstServePercentage, 
            'unforcedErrors': match.unforcedErrors, 
            'winners': match.winners, 
            'aces': match.aces, 
            'rating': match.rating, 
            'whatWentWell': match.whatWentWell, 
            'whatToImprove': match.whatCanImprove, 
            'notes': match.notes 
        }),

    ); 

    //handle response 
    final data = jsonDecode(response.body);
    int statusCode = response.statusCode; 
    
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(data['message']), 
      duration: const Duration(seconds: 2),
      showCloseIcon: true,
      ),);

    if (statusCode == 201){
        Navigator.pushNamed(context, '/registrationPage');
    }

}
