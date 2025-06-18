import 'package:flutter/cupertino.dart';

class RectangleArea extends StatelessWidget {
  const RectangleArea(
      {super.key,
        required this.label,
        required this.size,
        required this.color});

  final String label;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color),
      child: Center(child: Text(label, style: const TextStyle(fontSize: 16))),
    );
  }
}
