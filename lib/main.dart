import 'package:flutter/material.dart';
import 'package:kids_learning/a_alphabet.dart';
import 'package:kids_learning/abc.dart';
import 'package:kids_learning/123.dart';
import 'package:kids_learning/animal.dart';
import 'package:kids_learning/color.dart';
import 'package:kids_learning/fruits.dart';
import 'package:kids_learning/urdu.dart';
import 'package:kids_learning/vegetable.dart';



void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning',
      debugShowCheckedModeBanner: false,
      home:  FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Widget boxes(BuildContext context, String imagebox, Widget Function() onclick) {
        final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => onclick()),
        );
      },
      child: Container(
        height: screenWidth * 0.35,
        width: (MediaQuery.of(context).size.width - 80) / 3,

        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagebox),
            fit: BoxFit.cover,
          ),
        ),
        // child: Center(child: Text(text,style: TextStyle(fontSize: screenWidth * 0.09,fontFamily: "Chuby",color: clr),)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size dynamically
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg3.JPG"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            
            Container(
              height: screenHeight * 0.12,
              width: double.infinity,
              // color: Colors.green,
              child: Center(child: Text("Welcome to Kidz Learnig",style: TextStyle(fontSize: screenWidth*0.03,fontFamily: "Chuby",color: Colors.grey[200]),)),
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
  alignment: WrapAlignment.center,
  spacing: 20, // horizontal spacing
  runSpacing: 20, // vertical spacing
  children: [
    boxes(context, 'assets/images/abc.jpg', () => ABC()),
    boxes(context, 'assets/images/123.jpg', () => MATH()),
    boxes(context, 'assets/images/10.jpg', () => ANIMAL()),
    boxes(context, 'assets/images/urdu.jpeg', () => URDU()),
    boxes(context, 'assets/images/123.jpg', () => ALHPABETS()),
    boxes(context, 'assets/images/2.jpeg', () => FRUITS()),
     boxes(context, 'assets/images/abc.jpg', () => ABC()),
    boxes(context, 'assets/images/123.jpg', () => ABC()),
    boxes(context, 'assets/images/2.jpeg', () => ABC()),
    boxes(context, 'assets/images/abc.jpg', () => ABC()),
    boxes(context, 'assets/images/123.jpg', () => ABC()),
    boxes(context, 'assets/images/2.jpeg', () => ABC()),
  ],
)   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
