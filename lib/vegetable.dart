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
  runApp(const VEGETABLE());
}

class VEGETABLE extends StatefulWidget {
  const VEGETABLE({super.key});

  @override
  State<VEGETABLE> createState() => _VEGETABLEState();
}

class _VEGETABLEState extends State<VEGETABLE> {
  List<String> vegetable = [
    "assets/images/beet.png",
    "assets/images/bellpepper.png",
    "assets/images/broccoli.png",
    "assets/images/cabbage.png",
    "assets/images/carrot.png",

    "assets/images/cauliflower.png",
    "assets/images/corn.png",
    "assets/images/cucumber.png",
    "assets/images/eggplant.png",
    "assets/images/lettuce.png",
    "assets/images/onion.png",
    "assets/images/pea.png",
    "assets/images/potato.png",
    "assets/images/pumpkin.png",
    "assets/images/radish.png",
    "assets/images/redchilipepper.png",
    "assets/images/tomato.png",
  ];
  List<String> vegetable_image_name = [
    "Beet",
  "Bellpepper",
  "Broccoli",
  "Cabbage",
  "Carrot",
  "Cauliflower",
  "Corn",
  "Cucumber",
  "Eggplant",
  "Lettuce",
  "Onion",
  "Pea",
  "Potato",
  "Pumpkin",
  "Radish",
  "Redchilipepper",
  "Tomato",
  ];
  String get currentImagePath => "assets/images/${vegetable_image}";

  String vegetable_image = "assets/images/beet.png";
  String vegetable_image_name1 = "beet";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();

    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$vegetable_image_name1.mp3';
    await _player.play(AssetSource('audio/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = vegetable.indexOf(vegetable_image);
      vegetable_image = vegetable[(currentIndex + 1) % vegetable.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      vegetable_image_name1 =
          vegetable_image_name[(currentIndex + 1) % vegetable_image_name.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
       int currentIndex = vegetable.indexOf(vegetable_image);
      if (currentIndex > 0) {
        vegetable_image = vegetable[(currentIndex + 1) % vegetable.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      vegetable_image_name1 =
          vegetable_image_name[(currentIndex + 1) % vegetable_image_name.length];
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
                                vegetable_image,
                                fit: BoxFit.contain,
                              ),
                              
                            ),
                          ),
                          Text(
                            vegetable_image_name1,
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
