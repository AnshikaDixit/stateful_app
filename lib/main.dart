import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Stateful App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Tap the Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: (() {
          setState(() {
            //it cannot be null
            title = DateTime.now().toIso8601String();
          });
        }),
        child: Container(color: Colors.white),
      ),
    );
  }
}
