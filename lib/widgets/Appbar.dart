import 'package:flutter/material.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                const Color.fromARGB(255, 6, 58, 231),
                Colors.red,
                Colors.green,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'ROAD TO THE FIFA WORLD CUP 26 APP',
              style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
      ),
    );
  }
}
