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
  runApp(const URDU());
}

class  URDU extends StatefulWidget {
  const  URDU({super.key});

  @override
  State< URDU> createState() => _URDUState();
}

class _URDUState extends State< URDU> {
  List<String> urdu= [
  "ا", "ب", "پ", "ت", "ٹ", "ث", "ج", "چ", "ح", "خ",
  "د", "ڈ", "ذ", "ر", "ڑ", "ز", "ژ", "س", "ش", "ص",
  "ض", "ط", "ظ", "ع", "غ", "ف", "ق", "ک", "گ", "ل",
  "م", "ن", "و", "ہ", "ء", "ی", "ے"
];

  String get currentImagePath => "assets/images/$urdu_store.jpeg";

  

  String urdu_store = "ا";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$urdu_store.mp3';
    await _player.play(AssetSource('audio/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = urdu.indexOf(urdu_store);
      urdu_store = urdu[(currentIndex + 1) % urdu.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
      int currentIndex = urdu.indexOf(urdu_store);
      if (currentIndex > 0) {
        urdu_store = urdu[(currentIndex - 1) % urdu.length];
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
      title: 'urdu aplhabet Audio Player',
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
                    height: screenHeight * 0.7,
                    width: screenWidth * 0.5,
                    // color: Colors.red,
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: screenHeight*0.2),
                        child: Text(
                              urdu_store,
                              style: TextStyle(
                                fontFamily: 'noto',
                                fontSize: screenWidth * 0.2,
                                color: const Color.fromARGB(255, 222, 181, 166),
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
