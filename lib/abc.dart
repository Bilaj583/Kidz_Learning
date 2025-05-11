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
  runApp(const ABC());
}

class ABC extends StatefulWidget {
  const ABC({super.key});

  @override
  State<ABC> createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  List<String> abc = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
    "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  ];
  String get currentImagePath => "assets/images/${abc_store}.jpeg";

  

  String abc_store = "A";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$abc_store.mp3';
    await _player.play(AssetSource('audio/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = abc.indexOf(abc_store);
      abc_store = abc[(currentIndex + 1) % abc.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
      int currentIndex = abc.indexOf(abc_store);
      if (currentIndex > 0) {
        abc_store = abc[(currentIndex - 1) % abc.length];
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
                              abc_store,
                              style: TextStyle(
                                fontFamily: 'Titan',
                                fontSize: screenWidth * 0.25,
                                color: const Color.fromARGB(255, 202, 139, 116),
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
