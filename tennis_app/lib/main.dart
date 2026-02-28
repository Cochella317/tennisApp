import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          Column(
            children: [
              const SizedBox(height: 100),
              Card(elevation: 10,
              shadowColor: Colors.black,
              color: const Color.fromARGB(255, 226, 226, 226),   
              child: SizedBox(
                height: 650,
                width: 375, 
                child: Text("Hello")
                ),
              ), 
              const SizedBox(height: 15),
                SizedBox(
                  height: 50, 
                  width: 250, 
                  child: ElevatedButton(onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.black), 
                  ), 
                  child: Text("Add Match", style: GoogleFonts.lexend(
                    color: Colors.white, 
                    fontSize: 18.0 
                  )
                    )),
                ),
            ],
          ) 
      ),
    ); 
  }
}
