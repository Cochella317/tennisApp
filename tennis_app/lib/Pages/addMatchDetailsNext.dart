import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:tennis_app/models/match.dart';
import 'package:tennis_app/services/match_services.dart';

class AddMatchDetailsNext extends StatefulWidget {
  const AddMatchDetailsNext({super.key, required this.title, required this.match});
  final String title;
  final Match match;
  

  @override
  State<AddMatchDetailsNext> createState() => _AddMatchDetailsNextState();
}

class _AddMatchDetailsNextState extends State<AddMatchDetailsNext> {
  int rating = 3; 
  final whatWentWellText = TextEditingController();
  final whatCanImproveText = TextEditingController();
  final notesText = TextEditingController();

  @override 
  void dispose(){
    whatWentWellText.dispose(); 
    whatCanImproveText.dispose(); 
    notesText.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 1000, 
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 0, 8.0),
                  child: Text("MORE MATCH DETAILS",
                    style: GoogleFonts.lexend(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(children: [
                         Icon(
                          Icons.psychology_outlined,
                          color: const Color.fromARGB(255, 46, 126, 0),
                          size: 24.0,
                          semanticLabel: 'Brain Icon',
                        ),
            
                        const SizedBox(width: 6),
            
                        Text(
                          "MENTAL FOCUS",
                          style: GoogleFonts.lexend(
                            color: const Color.fromARGB(255, 46, 126, 0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                       ],),
            
                       const SizedBox(height: 10),
            
                       Text("How was your mental focus?",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                      const SizedBox(height: 10),
            
                       RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          this.rating = rating as int; 
                        },
                      ),
                      ],
                    ),
                  ),
                ),
            
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(children: [
                         Icon(
                          Icons.textsms_outlined,
                          color: const Color.fromARGB(255, 46, 126, 0),
                          size: 24.0,
                          semanticLabel: 'Message Icon',
                        ),
            
                        const SizedBox(width: 6),
            
                        Text(
                          "REFLECTION",
                          style: GoogleFonts.lexend(
                            color: const Color.fromARGB(255, 46, 126, 0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        const SizedBox(width: 6),
            
                        Text("(Optional)",
                                style: GoogleFonts.lexend(
                                  color:  Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                       ],),
            
                       const SizedBox(height: 12),
            
                       Text("What went well?",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        TextField(
                          maxLines: 8, // 5 lines high
                          maxLength: 1000, //max input in characters
                          keyboardType: TextInputType.multiline, 
                          controller: whatWentWellText,
                          decoration: InputDecoration(
                            hintText: "Enter your text here...",
                            border: OutlineInputBorder(), // box around field 
                          ),
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        const SizedBox(height: 25),
            
                        Text("What can you improve?",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        TextField(
                          maxLines: 8, // 8 lines high
                          maxLength: 1000, //max input in characters
                          keyboardType: TextInputType.multiline, 
                          controller: whatCanImproveText,
                          decoration: InputDecoration(
                            hintText: "Enter your text here...",
                            border: OutlineInputBorder(), // box around field 
                          ),
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(children: [
                         Icon(
                          Icons.create_outlined,
                          color: const Color.fromARGB(255, 46, 126, 0),
                          size: 24.0,
                          semanticLabel: 'Message Icon',
                        ),
            
                        const SizedBox(width: 6),
            
                        Text(
                          "NOTES",
                          style: GoogleFonts.lexend(
                            color: const Color.fromARGB(255, 46, 126, 0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        const SizedBox(width: 6),
            
                        Text("(Optional)",
                                style: GoogleFonts.lexend(
                                  color:  Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                       ],),
            
                      const SizedBox(height: 20),
            
                       TextField(
                          maxLines: 8, // 8 lines high
                          maxLength: 2000, //max input in characters
                          keyboardType: TextInputType.multiline, 
                          controller: notesText,
                          decoration: InputDecoration(
                            hintText: "Enter your text here...",
                            border: OutlineInputBorder(), // box around field 
                          ),
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),
              
                SizedBox(
                  height: 50, 
                  width: 300, 
                  child: ElevatedButton(
                    onPressed: () {
                      widget.match.rating = rating; 
                      widget.match.whatWentWell = whatWentWellText.text; 
                      widget.match.whatCanImprove = whatCanImproveText.text; 
                      widget.match.notes = notesText.text; 
                      createMatch(widget.match, context); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 46, 126, 0),
                      side: BorderSide(
                        color:  const Color.fromARGB(255, 46, 126, 0),
                          width: 1.0,
                      
                      )
                        ), 
                      child: Text("Save Match", style: GoogleFonts.lexend(
                        color: Colors.white, 
                        fontSize: 18.0 
                      )
                    )
                  ),
                ),

                const SizedBox(height: 15),
              
                SizedBox(
                  height: 50, 
                  width: 300, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      side: BorderSide(
                        color:  Colors.black,
                          width: 1.0,
                      
                      )
                        ), 
                      child: Text("Back", style: GoogleFonts.lexend(
                        color: Colors.black, 
                        fontSize: 18.0 
                      )
                    )
                  ),
                ),
            
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
