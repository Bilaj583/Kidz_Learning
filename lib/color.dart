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
  runApp(const COLOR());
}

class COLOR extends StatefulWidget {
  const COLOR({super.key});

  @override
  State<COLOR> createState() => _COLORState();
}

class _COLORState extends State<COLOR> {
  List<Color> color = [
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];
  List<String> color_image_name = [
   "red",
   "green",
   "yellow",
  ];
  String get currentImagePath => "assets/images/${color_image}";

  Color color_image = Colors.red;
  String color_image_name1 = "red";
  final AudioPlayer _player = AudioPlayer();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _playAudio();

    _startAutoNavigation();
  }

  void _playAudio() async {
    final filename = '$color_image_name1.mp3';
    await _player.play(AssetSource('audio/$filename'));
  }

  void move_forward() {
    setState(() {
      int currentIndex = color.indexOf(color_image);
      color_image = color[(currentIndex + 1) % color.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      color_image_name1 =
          color_image_name[(currentIndex + 1) % color_image_name.length];
    });
    _playAudio();
  }

  void move_backward() {
    setState(() {
       int currentIndex = color.indexOf(color_image);
      if (currentIndex > 0) {
        color_image = color[(currentIndex + 1) % color.length];
      // int currentIndex1 = animal.indexOf(animal_image);
      color_image_name1 =
          color_image_name[(currentIndex + 1) % color_image_name.length];
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
                            child: SizedBox(
                              height: screenHeight*0.34,
                              width: screenWidth*0.34,
                              
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.3,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                    color: color_image,
                                    borderRadius: BorderRadius.circular(150)
                                  ),
                                  
                                  
                                ),
                              ),
                            ),
                          ),
                          Text(
                            color_image_name1,
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
