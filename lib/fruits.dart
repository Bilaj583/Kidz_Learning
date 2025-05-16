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
  runApp(const FRUITS());
}

class FRUITS extends StatefulWidget {
  const FRUITS({super.key});

  @override
  State<FRUITS> createState() => _FRUITSSState();
}

class _FRUITSSState extends State<FRUITS> {
  List<String> fruits = [
    "assets/images/fruits/banana.png",
    "assets/images/fruits/blueberry.png",
    "assets/images/fruits/cherry.png",
    "assets/images/fruits/kiwi.png",
    "assets/images/fruits/lemon.png",
    "assets/images/fruits/lychee.png",
    "assets/images/fruits/peach.png",
    "assets/images/fruits/pineapple.png",
    "assets/images/fruits/strawberry.png",
    "assets/images/fruits/watermelon.png",
  ];
  List<String> fruits_image_name = [
    "Banana",
"Blueberry",
"Cherry",
"Kiwi",
"Lemon",
"Lychee",
"Peach",
"Pineapple",
"strawberry",
"Watermelon"
  ];
  String get currentImagePath => "assets/images/fruits/${fruits_image}";

  String fruits_image = "assets/images/fruits/banana.png";
  String fruits_image_name1 = "Banana";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();

    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$fruits_image_name1.mp3';
    await _player.play(AssetSource('audio/fruits/$filename'));
  }

  void move_forward() {
  setState(() {
    int currentIndex = fruits.indexOf(fruits_image);
    int nextIndex = (currentIndex + 1) % fruits.length;
    fruits_image = fruits[nextIndex];
    fruits_image_name1 = fruits_image_name[nextIndex];
  });
  _playAudio();
}


  void move_backward() {
  setState(() {
    int currentIndex = fruits.indexOf(fruits_image);
    int previousIndex = (currentIndex - 1 + fruits.length) % fruits.length;
    fruits_image = fruits[previousIndex];
    fruits_image_name1 = fruits_image_name[previousIndex];
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
                            padding:  EdgeInsets.only(top: screenHeight*0.16),
                            child: Container(
                              height: screenHeight * 0.5,
                              width: screenWidth * 0.5,
                              // color: Colors.red,
                              child: Image.asset(
                                fruits_image,
                                fit: BoxFit.contain,
                              ),
                              
                            ),
                          ),
                          Text(
                            fruits_image_name1,
                            style: TextStyle(
                              fontSize: screenWidth * 0.07,
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
