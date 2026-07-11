import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class AddMatchDetails extends StatefulWidget {
  const AddMatchDetails({super.key, required this.title});
  final String title;

  @override
  State<AddMatchDetails> createState() => _AddMatchDetailsState();
}

class _AddMatchDetailsState extends State<AddMatchDetails> {
  DateTime? selectedDate;
  String selectedSurface = "Hard";
  String opponentName = ""; 
  String selectedMatchType = "Singles"; 
  List<int?> myScores = List.filled(5, null);
  List<int?> opponentScores = List.filled(5, null);
  String score = ""; 
  num? firstServePercentage; 
  int? unforcedErrors; 
  int? winners; 
  int? aces; 


  void _selectDate(BuildContext context) async {
  final ThemeData theme = Theme.of(context);
  assert(theme.platform != null);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return buildMaterialDatePicker(context);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return buildCupertinoDatePicker(context);
  }
}
/// This builds material date picker in Android
Future<void> buildMaterialDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2055),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light(),
        child: child!,
      );
    },
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
    });
  }
}
/// This builds cupertion date picker in iOS
void buildCupertinoDatePicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            initialDateTime: selectedDate,
            minimumYear: 2000,
            maximumYear: 2055,
          ),
        );
      });
}

String getMatchResult() {
  int mySetsWon = 0;
  int oppSetsWon = 0;

  for (int i = 0; i < 5; i++) {
    if (myScores[i] != null && opponentScores[i] != null) {
      if (myScores[i]! > opponentScores[i]!) {
        mySetsWon++;
      } else if (myScores[i]! < opponentScores[i]!) {
        oppSetsWon++;
      }
    }
  }

  if (mySetsWon > oppSetsWon) {
    return "Win";
  }
  if (oppSetsWon > mySetsWon){
    return "Loss";
  } 
  return "";
}

String getFinalScore() {
  List<String> sets = [];

  for (int i = 0; i < 5; i++) {
    if (myScores[i] != null && opponentScores[i] != null) {
      sets.add("${myScores[i]}-${opponentScores[i]}");
    }
  }

  return sets.join(", ");
}

void checkInput(){
  
}

Widget buildSurfaceChips() {
  final surfaces = ["Hard", "Clay", "Grass", "Indoor"];
  return Wrap(
    spacing: 8,
    children: surfaces.map((surface) {
      return ChoiceChip(
        label: Text(surface),
        selected: selectedSurface == surface,
        onSelected: (isSelected) {
          setState(() {
            selectedSurface = surface;
          });
        },
        selectedColor: const Color.fromARGB(255, 46, 126, 0),
        backgroundColor: Colors.grey[200],
        checkmarkColor: Colors.white,
        labelStyle: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: selectedSurface == surface ? Colors.white : Colors.black,
        ),
      );
    }).toList(),
  );
}

Widget buildMatchTypeChips() {
  final matchTypes = ["Singles", "Doubles"];
  return Wrap(
    spacing: 8,
    children: matchTypes.map((matchType) {
      return ChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              matchType == "Singles" ? Icons.person : Icons.group,
              size: 18,
              color: selectedMatchType == matchType ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 6),
            Text(matchType),
          ],
        ),
        selected: selectedMatchType == matchType,
        onSelected: (isSelected) {
          setState(() {
            selectedMatchType = matchType;
          });
        },
        showCheckmark: false,
        selectedColor: const Color.fromARGB(255, 46, 126, 0),
        backgroundColor: Colors.grey[200],
        checkmarkColor: Colors.white,
        labelStyle: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: selectedMatchType == matchType ? Colors.white : Colors.black,
        ),
      );
    }).toList(),
  );
}

Widget buildSetRow(String label, int rowNum){
   return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label, 
          style: GoogleFonts.lexend(        
            color: Colors.black,
            fontSize: 16.0,
            ), 
          ),
        ),

        // Your score
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (value) {
              setState(() {
                myScores[rowNum] = int.tryParse(value);
                score = getFinalScore(); 
              });
            },
          ),
        ),

        const SizedBox(width: 8),
        Text("-"),
        const SizedBox(width: 8),

        // Opponent score
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (value) {
              setState(() {
                opponentScores[rowNum] = int.tryParse(value);
              });
            },
          ),
        ),
      ],
    ),
  );

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          SingleChildScrollView(
            child: Column(
              children: [
                //const SizedBox(height: 50),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 0, 8.0),
                  child: Text("MATCH DETAILS", style: GoogleFonts.lexend(
                      color: const Color.fromARGB(255, 0, 0, 0), 
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600 
                    )
                  )
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
            
                        // Label
                        Text("Opponent",
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        const SizedBox(height: 8),
            
                        // TextBox
                        TextField(
                          onChanged: (name) {
                            opponentName = name; 
                          },
                          decoration: InputDecoration(
                            hintText: "Enter opponent name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 15),
            
                        // Label
                        Text("Date",
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
            
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255), 
                            borderRadius: BorderRadius.circular(15), 
                            border: Border.all(color: Colors.black, width: 1),
                              ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.black,
                                  size: 24.0,
                                  semanticLabel: 'Calendar Icon' 
                                ),
            
                                 const SizedBox(width: 10),
            
                                Text( selectedDate == null ? "Select a date" : DateFormat('MMM d, y').format(selectedDate!),
                                style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
            
                        const SizedBox(height: 15),
            
                        // Label
                        Text("Surface",
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                        buildSurfaceChips(),
            
                        const SizedBox(height: 15),
            
                        // Label
                        Text("Match Type",
                          style: GoogleFonts.lexend(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            
                      
                        buildMatchTypeChips(),
            
            
            
                      ],
                    ),
                  ),
                ),
            
            
                const SizedBox(height: 15),
            
                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_events_outlined,
                              color: const Color.fromARGB(255, 46, 126, 0),
                            ),
            
            
                            const SizedBox(width: 8),
            
                            // Label
                            Text("SCORE",
                              style: GoogleFonts.lexend(
                                color: const Color.fromARGB(255, 46, 126, 0),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]
            
                        ),
            
                         const SizedBox(height: 20),
            
                          // Result (Win/Loss)
                        Align(
                          alignment: AlignmentGeometry.xy(0.43, 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                            decoration: BoxDecoration(
                              color: getMatchResult() == "Win"
                                  ? Colors.green[100]
                                  : getMatchResult() == "Loss"
                                  ? Colors.red[100]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(getMatchResult(), 
                              style: GoogleFonts.lexend(
                              color: getMatchResult() == "Win"
                                  ? const Color.fromARGB(255, 46, 126, 0)
                                  : const Color.fromARGB(255, 126, 46, 0),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
            
                        buildSetRow("Set 1", 0), 
                        buildSetRow("Set 2", 1),
                        buildSetRow("Set 3", 2),
                        buildSetRow("Set 4 (Optional)", 3),
                        buildSetRow("Set 5 (Optional)", 4),
            
                        const SizedBox(height: 25),
            
                        // Final score
                        Row(
                          children: [
                            Text("Final Score",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(width: 50),

                            Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                            decoration: BoxDecoration(
                              color: getMatchResult() == "Win"
                                  ? Colors.green[100]
                                  : getMatchResult() == "Loss"
                                  ? Colors.red[100]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(getFinalScore(), 
                              style: GoogleFonts.lexend(
                              color: getMatchResult() == "Win"
                                  ? const Color.fromARGB(255, 46, 126, 0)
                                  : const Color.fromARGB(255, 126, 46, 0),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ],
                        ),
            
                      ],
            
                    )
                  )
                ),

                const SizedBox(height: 15),


                Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bar_chart_sharp,
                              color: const Color.fromARGB(255, 46, 126, 0),
                              size: 24.0,
                              semanticLabel: 'Stats Icon'
                            
                            ),

                            const SizedBox(width: 6),

                            Text("QUICK STATS",
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

                          ],
                        ),

                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Icon(
                              Icons.sports_baseball_outlined,
                              color: const Color.fromARGB(255, 46, 126, 0),
                              size: 24.0,
                              semanticLabel: 'Tennis Ball Icon'
                            ),

                            const SizedBox(width: 10),

                            Text("First Serve %",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ), 
                            ),

                            const SizedBox(width: 80),

                            Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  firstServePercentage = double.tryParse(value);
                                  });
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text("%",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ), 
                            ),

                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: const Color.fromARGB(255, 46, 126, 0),
                              size: 24.0,
                              semanticLabel: 'Exclamation Icon'
                            ),

                            const SizedBox(width: 10),

                            Text("Unforced Errors",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ), 
                            ),

                            const SizedBox(width: 60),

                            Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  unforcedErrors = int.tryParse(value);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 22),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: const Color.fromARGB(255, 46, 126, 0),
                              size: 24.0,
                              semanticLabel: 'Star Icon'
                            ),

                            const SizedBox(width: 10),

                            Text("Winners",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ), 
                            ),

                            const SizedBox(width: 123),

                            Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  winners = int.tryParse(value);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 22),
                          ],
                        ),

                         const SizedBox(height: 15),

                        Row(
                          children: [
                            Icon(
                              Icons.rocket_launch_outlined,
                              color: const Color.fromARGB(255, 46, 126, 0),
                              size: 24.0,
                              semanticLabel: 'Rocket Icon'
                            ),

                            const SizedBox(width: 10),

                            Text("Aces",
                              style: GoogleFonts.lexend(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ), 
                            ),

                            const SizedBox(width: 150),

                            Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  aces = int.tryParse(value);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 22),
                          ],
                        ),




                      ]

                    ),
                    
                  ), 

                ),

                const SizedBox(height: 15),
            
                  SizedBox(
                    height: 50, 
                    width: 250, 
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        side: BorderSide(
                          color:  Colors.black,
                           width: 1.0,
            
                        )
                          ), 
                        child: Text("Next", style: GoogleFonts.lexend(
                          color: Colors.black, 
                          fontSize: 18.0 
                        )
                      )
                    ),
                  ),
              ],
            ),
          ) 
      ),
    ); 
  }

  
}
