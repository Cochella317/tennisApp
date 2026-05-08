import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class SignInPage extends StatefulWidget{
  const SignInPage({super.key, required this.title});
  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  String? email; 
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
              Container(
                padding: EdgeInsets.fromLTRB(98, 130, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                        Text("Welcome Back!",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lexend(
                          color: const Color.fromARGB(255, 46, 126, 0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),
                        
                        Text("Sign in to continue tracking your tennis journey.",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lexend(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
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

                        TextField(
                          onChanged: (value) {
                             password = value; 
                          },
                          obscureText: true,
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
                          ),
                        ),

                        const SizedBox(height: 30),

                       
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 46, 126, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8)
                              )
                            ),
                            child: Text("Sign In",
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
                              children: [

                                const SizedBox(width: 50),

                                Image.asset('lib/assets/web_light_rd_na@1x.png'),

                                const SizedBox(width: 20),

                                Text("Sign In With Google",
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

    );
  }

}