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
    "assets/images/letter/apple.png",
    "assets/images/letter/ball.png",
    "assets/images/letter/cat.png",
    "assets/images/letter/dog.png",
    "assets/images/letter/elephant.png",
    "assets/images/letter/flower.png",
    "assets/images/letter/grapes.png",
    "assets/images/letter/hat.png",
    "assets/images/letter/icecream.png",
    "assets/images/letter/jug.png",
    "assets/images/letter/kite.png",
    "assets/images/letter/lamp.png",
    "assets/images/letter/mango.png",
    "assets/images/letter/nest.png",
    "assets/images/letter/orange.png",
    "assets/images/letter/pencil.png",
    "assets/images/letter/queen.png",
    "assets/images/letter/rose.png",
    "assets/images/letter/sun.png",
    "assets/images/letter/tiger.png",
    "assets/images/letter/umbrella.png",
    "assets/images/letter/van.png",
    "assets/images/letter/water.png",
    "assets/images/letter/xray.png",
    "assets/images/letter/yogart.png",
    "assets/images/letter/zirafa.png",
    
    
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
  String get currentImagePath => "assets/images/letter/${alphabet_image}";

  String alphabet_image = "assets/images/letter/apple.png";
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
    await _player.play(AssetSource('audio/letter/$filename'));
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
                              height: screenHeight * 0.4,
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
