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
  runApp(const ANIMAL());
}

class ANIMAL extends StatefulWidget {
  const ANIMAL({super.key});

  @override
  State<ANIMAL> createState() => _ANIMALState();
}

class _ANIMALState extends State<ANIMAL> {
  List<String> animal = [
    "assets/images/animal/fish.png",
    "assets/images/animal/fox.png",
    "assets/images/animal/girafa.png",
    "assets/images/animal/goat.png",
    "assets/images/animal/horse.png",
    "assets/images/animal/ostrich.png",
    "assets/images/animal/mouse.png",
    "assets/images/animal/monkey.png",
    "assets/images/animal/hen.png",
  ];
  List<String> animal_image_name = [
    "fish",
    "fox",
    "girafa",
    "goat",
    "horse",
    "ostrich",
    "mouse",
    "monkey",
    "hen",
  ];
  String get currentImagePath => "assets/images/animal/${animal_image}";

  String animal_image = "assets/images/animal/fish.png";
  String animal_image_name1 = "fish";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();

    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$animal_image_name1.mp3';
    await _player.play(AssetSource('audio/animal/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = animal.indexOf(animal_image);
      animal_image = animal[(currentIndex + 1) % animal.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      animal_image_name1 =
          animal_image_name[(currentIndex + 1) % animal_image_name.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
      int currentIndex = animal.indexOf(animal_image);
      if (currentIndex > 0) {
        animal_image = animal[(currentIndex - 1) % animal.length];
        animal_image_name1 =
            animal_image_name[(currentIndex - 1) % animal_image_name.length];
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
                // SizedBox(
                //   height: screenHeight*0.,
                // ),
                Center(
                  child: Container(
                    height: screenHeight * 0.9,
                    width: screenWidth * 0.7,
                    // color: Colors.red,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: screenHeight*0.18),
                            child: Container(
                              height: screenHeight * 0.5,
                              width: screenWidth * 0.5,
                              // color: Colors.red,
                              child: Image.asset(
                                animal_image,
                                fit: BoxFit.contain,
                              ),
                              
                            ),
                          ),
                          Text(
                            animal_image_name1,
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontFamily: "Chuby",
                              color: Colors.greenAccent,
                            ),
                          ),
                          
                        ],
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
