import 'package:beacon/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        title: "Smart Receptionist",
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
