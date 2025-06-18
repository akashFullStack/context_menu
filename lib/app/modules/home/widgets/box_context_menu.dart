import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class BoxWithContextMenu extends StatelessWidget {
  final Widget child;
  final VoidCallback onRightClick;

  const BoxWithContextMenu(
      {super.key, required this.child, required this.onRightClick});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton) {
          onRightClick();
        }
      },
      child: child,
    );
  }
}
