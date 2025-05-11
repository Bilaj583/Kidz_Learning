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
  runApp(const ALHPABETS());
}

class ALHPABETS extends StatefulWidget {
  const ALHPABETS({super.key});

  @override
  State<ALHPABETS> createState() => _ALHPABETSState();
}

class _ALHPABETSState extends State<ALHPABETS> {
  List<String> alphabets = [
    "assets/images/apple.png",
    "assets/images/ball.png",
    "assets/images/cat.png",
    "assets/images/dog.png",
    "assets/images/elephant.png",
    "assets/images/flower.png",
    "assets/images/grapes.png",
    "assets/images/hat.png",
    "assets/images/icecream.png",
    "assets/images/jug.png",
    "assets/images/kite.png",
    "assets/images/lamp.png",
    "assets/images/mango.png",
    "assets/images/nest.png",
    "assets/images/orange.png",
    "assets/images/pencil.png",
    "assets/images/queen.png",
    "assets/images/rose.png",
    "assets/images/sun.png",
    "assets/images/tiger.png",
    "assets/images/umbrella.png",
    "assets/images/van.png",
    "assets/images/water.png",
    "assets/images/xray.png",
    "assets/images/yogart.png",
    "assets/images/zirafa.png",
    
    
  ];
  List<String> alphabet_image_name = [
    "Apple",
"Ball",
"Cat",
"Dog",
"Elephant",
"Flower",
"Grapes",
"Hat",
"Icecream",
"Jug",
"Kite",
"Lamp",
"Mango",
"Nest",
"Orange",
"Pencil",
"Queen",
"Rose",
"Sun",
"Tiger",
"Umbrella",
"Van",
"Water",
"Xray",
"Yogart",
"Zirafa" 
  ];
  String get currentImagePath => "assets/images/${alphabet_image}";

  String alphabet_image = "assets/images/apple.png";
  String alphabet_image_name1 = "Apple";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();

    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$alphabet_image_name1.mp3';
    await _player.play(AssetSource('audio/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = alphabets.indexOf(alphabet_image);
      alphabet_image = alphabets[(currentIndex + 1) % alphabets.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      alphabet_image_name1 =
          alphabet_image_name[(currentIndex + 1) % alphabet_image_name.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
      int currentIndex = alphabets.indexOf(alphabet_image);
      if (currentIndex > 0) {
        alphabet_image = alphabets[(currentIndex - 1) % alphabets.length];
        alphabet_image_name1 =
            alphabet_image_name[(currentIndex - 1) % alphabet_image_name.length];
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
                            padding:  EdgeInsets.only(top: screenHeight*0.16),
                            child: Container(
                              height: screenHeight * 0.5,
                              width: screenWidth * 0.5,
                              // color: Colors.red,
                              child: Image.asset(
                                alphabet_image,
                                fit: BoxFit.contain,
                              ),
                              
                            ),
                          ),
                          Text(
                            alphabet_image_name1,
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
