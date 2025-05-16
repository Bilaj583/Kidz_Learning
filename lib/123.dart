import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:flutter/services.dart'; // ✅ Import services for orientation control

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensures services binding is initialized
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const MATH());
}

class MATH extends StatefulWidget {
  const MATH({super.key});

  @override
  State<MATH> createState() => _ABCState();
}

class _ABCState extends State<MATH> {
  List<String> counting = [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16",
    "17", "18", "19", "20", 
  ];
  String get currentImagePath => "assets/images/${counting_store}.jpeg";

  

  String counting_store = "1";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$counting_store.mp3';
    await _player.play(AssetSource('audio/counting/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = counting.indexOf(counting_store);
      counting_store = counting[(currentIndex + 1) % counting.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
      int currentIndex = counting.indexOf(counting_store);
      if (currentIndex > 0) {
        counting_store = counting[(currentIndex - 1) % counting.length];
      }
    });
    _playAudio();
  }

  void _startAutoNavigation() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      move_forward();
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'ABC Audio Player',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/8.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // SizedBox(
                //   height: screenHeight * 0.15,
                  
                // ),
                Center(
                  child: Container(
                    height: screenHeight * 0.9,
                    width: screenWidth * 0.5,
                    // color: Colors.red,
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: screenHeight*0.08),
                        child: Text(
                              counting_store,
                              style: TextStyle(
                                fontFamily: 'Titan',
                                fontSize: screenWidth * 0.25,
                                color: const Color.fromARGB(255, 245, 24, 68),
                              ),
                            ),
                      ),
                    ),
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
