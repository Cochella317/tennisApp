import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/services/auth_services.dart';


class registrationPage extends StatefulWidget{
  const registrationPage({super.key, required this.title});
  final String title;

  @override
  State<registrationPage> createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage>{
  String? firstName;
  String? lastName; 
  String? email; 
  String? password;
  String? confirmPassword;
  bool obscurePassword = true; 

  void verifyRegistrationInput(){
    if (firstName == null || lastName == null || email == null || password == null || confirmPassword == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("One or more field(s) are empty.")),);
    } else if (password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")),);
    } 
    //check length of password 
    else if (password!.length < 8){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password needs to be at least 8 characters")),);
    } else {
      createUser(firstName, lastName, email, password, context);
    }

    

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1000, 
          child: Column(
            children: [
                Container(
                  padding: EdgeInsets.fromLTRB(98, 130, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tennis",
                        style: GoogleFonts.lexend(
                          color: const Color.fromARGB(255, 46, 126, 0),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("Tracker",
                        style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 30),
          
                Card(
                  elevation: 3,
                    shadowColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Registration",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: const Color.fromARGB(255, 46, 126, 0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          const SizedBox(height: 10),
                          
                          Text("Join TennisTrack and elevate your game.",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          const SizedBox(height: 20),
          
                          Text("First Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          //first name
                           TextField(
                            onChanged: (value) {
                               firstName = value; 
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your first name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: const Color.fromARGB(255, 46, 126, 0),
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 20),
          
                          Text("Last Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          //last name
                           TextField(
                            onChanged: (value) {
                               lastName = value; 
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your last name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: const Color.fromARGB(255, 46, 126, 0),
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 20),
          
                          Text("Email",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          //email
                          TextField(
                            onChanged: (value) {
                               email = value; 
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: const Color.fromARGB(255, 46, 126, 0),
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 20),
          
                          Text("Password",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          //password
                          TextField(
                            onChanged: (value) {
                               password = value; 
                            },
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: const Color.fromARGB(255, 46, 126, 0),
                              ),
                             suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 30),
          
                           Text("Confirm Password",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          //confirm password
                          TextField(
                            onChanged: (value) {
                               confirmPassword = value; 
                            },
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Confirm your password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: const Color.fromARGB(255, 46, 126, 0),
                              ),
                              suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
          
                          const SizedBox(height: 30),
          
                         
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                verifyRegistrationInput();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 46, 126, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(8)
                                )
                              ),
                              child: Text("Create Account",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lexend(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,)
                              )
                            ),
                          ),
          
                            // Source - https://stackoverflow.com/a/54058761
                            // Posted by Jerome Escalante
                            // Retrieved 2026-05-07, License - CC BY-SA 4.0
                          Row(
                              children: <Widget>[
                                  Expanded(
                                      child: Divider(
                                        thickness: 1, // Adjust thickness as needed
                                        color: Colors.grey,
                                      )
                                  ),       
          
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("or"),
                                  ),        
          
                                  Expanded(
                                      child: Divider(
                                        thickness: 1, // Adjust thickness as needed
                                        color: Colors.grey,
                                      )
                                  ),
                              ]
                          ),
          
          
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signInPage');
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(8)
                                ),
                                side: BorderSide(
                                  color: Colors.grey
          
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign in",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexend(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,)
                                  ),
          
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
          
                    )
                )
            ],
          ),
        ),
      ),

    );

  }

} 