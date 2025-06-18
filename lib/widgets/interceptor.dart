import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Interceptor extends StatelessWidget {
  final Widget child;

  const Interceptor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (kIsWeb &&
            event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton) {
          // Intercept native context menu
          debugPrint('Right-click intercepted.');
        }
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
