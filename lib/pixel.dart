import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final Color color;
  var child;
  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: color),
      margin: const EdgeInsets.all(1),
      child: Center(
        child: Text(child.toString(),
          style: const TextStyle(color: Colors.white70),),
      ),
    );
  }
}
