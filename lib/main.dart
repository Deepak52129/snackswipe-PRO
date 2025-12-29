import 'package:flutter/material.dart';
import 'package:snacksswipe_pro/screens/swipe_screen.dart';


void main() {
  runApp(const SnackSwipeApp());
}

class SnackSwipeApp extends StatelessWidget {
  const SnackSwipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SnackSwipe Pro",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SwipeScreen(), // Starting screen
    );
  }
}
